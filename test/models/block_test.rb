# == Schema Information
#
# Table name: blocks
#
#  id            :bigint           not null, primary key
#  blockchain_id :bigint           not null
#  block_id      :string           not null
#  height        :bigint           not null
#  block_hash    :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  time          :datetime         not null
#
class BlockTest < ActiveSupport::TestCase
  def setup
    @blockchain = Blockchain.create!(name: "Test Blockchain")
    @block = @blockchain.blocks.build(
      block_id: "block_123",
      height: 1,
      block_hash: SecureRandom.hex(32),
      time: Time.now,
      created_at: Time.now,
      updated_at: Time.now
    )
  end

  test "should be valid with all attributes" do
    assert @block.valid?
  end

  test "should be invalid without block_hash" do
    @block.block_hash = nil
    assert_not @block.valid?
    assert_includes @block.errors[:block_hash], "can't be blank"
  end

  test "should be invalid without height" do
    @block.height = nil
    assert_not @block.valid?
    assert_includes @block.errors[:height], "can't be blank"
  end

  test "should be invalid without time" do
    @block.time = nil
    assert_not @block.valid?
    assert_includes @block.errors[:time], "can't be blank"
  end

  test "should be invalid without block_id" do
    @block.block_id = nil
    assert_not @block.valid?
    assert_includes @block.errors[:block_id], "can't be blank"
  end

  test "should be invalid without created_at" do
    @block.created_at = nil
    assert_not @block.valid?
    assert_includes @block.errors[:created_at], "can't be blank"
  end

  test "should be invalid without updated_at" do
    @block.updated_at = nil
    assert_not @block.valid?
    assert_includes @block.errors[:updated_at], "can't be blank"
  end

  test "should be invalid with a non-unique block_hash" do
    duplicate_block = @block.dup
    @block.save
    assert_not duplicate_block.valid?
    assert_includes duplicate_block.errors[:block_hash], "has already been taken"
  end

  test "should belong to a blockchain" do
    assert_respond_to @block, :blockchain
  end

  test "should have many block_transactions" do
    assert_respond_to @block, :block_transactions
  end

  test "should destroy associated block_transactions" do
    @block.save
    @block.block_transactions.create!(
      transaction_hash: "txnhash1",
      sender: "sender",
      receiver: "receiver",
      gas_burnt: 1000,
      success: true,
      actions_count: 2
    )

    assert_difference 'BlockTransaction.count', -1 do
      @block.destroy
    end
  end
end
