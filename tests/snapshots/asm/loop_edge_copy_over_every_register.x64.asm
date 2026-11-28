
loop_edge_copy_over_every_register.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<mix>:
               	subq	$0x98, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x48(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	movq	%rsi, 0x40(%rsp)
               	movq	0x48(%rsp), %rax
               	movq	(%rax), %rbp
               	movq	0x40(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, 0xb0(%rsp)
               	xorq	%rbp, %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	0x8(%rax), %rdi
               	movq	0x8(%rcx), %r10
               	movq	%r10, 0xa8(%rsp)
               	xorq	%rdi, %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	0x10(%rax), %rbx
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0xa0(%rsp)
               	xorq	%rbx, %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	0x18(%rax), %r12
               	movq	0x18(%rcx), %r8
               	xorq	%r12, %r8
               	movq	0x20(%rax), %r13
               	movq	0x20(%rcx), %r9
               	xorq	%r13, %r9
               	movq	0x28(%rax), %r14
               	movq	0x28(%rcx), %rdx
               	xorq	%r14, %rdx
               	movq	0x30(%rax), %r15
               	movq	0x30(%rcx), %rsi
               	xorq	%r15, %rsi
               	movq	0x38(%rax), %rax
               	movq	0x38(%rcx), %rcx
               	xorq	%rax, %rcx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x68(%rsp)
               	cmpl	$0xa, %r10d
               	jge	<addr>
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0xb8(%rsp)
               	movq	%rbp, %r10
               	shrq	$0x38, %r10
               	movq	0xb8(%rsp), %r11
               	movq	(%r11,%r10,8), %r11
               	movq	%r11, 0xb8(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x800(%r10), %r11
               	movq	%rax, %r10
               	shrq	$0x30, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0xb8(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0xb8(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1000(%r10), %r11
               	movq	%r15, %r10
               	shrq	$0x28, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0xb8(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0xb8(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1800(%r10), %r11
               	movq	%r14, %r10
               	shrq	$0x20, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0xb8(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0xb8(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x2000(%r10), %r11
               	movq	%r13, %r10
               	shrq	$0x18, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0xb8(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0xb8(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x2800(%r10), %r11
               	movq	%r12, %r10
               	shrq	$0x10, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0xb8(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0xb8(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x3000(%r10), %r11
               	movq	%rbx, %r10
               	shrq	$0x8, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0xb8(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0xb8(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x3800(%r10), %r11
               	movq	%r11, 0x98(%rsp)
               	movq	%rdi, %r10
               	andq	$0xff, %r10
               	movq	0x98(%rsp), %r11
               	movq	(%r11,%r10,8), %r10
               	movq	0xb8(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0xb8(%rsp)
               	movq	0x58(%rsp), %r11
               	movq	%r9, 0x30(%rsp)
               	movq	0x68(%rsp), %r9
               	movq	(%r11,%r9,8), %r10
               	movq	0xb8(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0xb8(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x98(%rsp)
               	movq	%rdi, %r10
               	shrq	$0x38, %r10
               	movq	0x98(%rsp), %r11
               	movq	(%r11,%r10,8), %r11
               	movq	%r11, 0x98(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x800(%r10), %r11
               	movq	%rbp, %r10
               	shrq	$0x30, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x98(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x98(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1000(%r10), %r11
               	movq	%rax, %r10
               	shrq	$0x28, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x98(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x98(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1800(%r10), %r11
               	movq	%r15, %r10
               	shrq	$0x20, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x98(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x98(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x2000(%r10), %r11
               	movq	%r14, %r10
               	shrq	$0x18, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x98(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x98(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x2800(%r10), %r11
               	movq	%r13, %r10
               	shrq	$0x10, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x98(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x98(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x3000(%r10), %r11
               	movq	%r12, %r10
               	shrq	$0x8, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x98(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x98(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	addq	$0x3800, %r10           # imm = 0x3800
               	movq	%rbx, %r11
               	andq	$0xff, %r11
               	movq	(%r10,%r11,8), %r10
               	movq	0x98(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x98(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%rbx, %r11
               	shrq	$0x38, %r11
               	movq	0x30(%rsp), %r9
               	movq	%r9, 0x38(%rsp)
               	movq	(%r10,%r11,8), %r9
               	movq	%r9, 0x90(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x800(%r10), %r11
               	movq	%rdi, %r10
               	shrq	$0x30, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x90(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x90(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1000(%r10), %r11
               	movq	%rbp, %r10
               	shrq	$0x28, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x90(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x90(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1800(%r10), %r11
               	movq	%rax, %r10
               	shrq	$0x20, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x90(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x90(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x2000(%r10), %r11
               	movq	%r15, %r10
               	shrq	$0x18, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x90(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x90(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x2800(%r10), %r11
               	movq	%r14, %r10
               	shrq	$0x10, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x90(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x90(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x3000(%r10), %r11
               	movq	%r13, %r10
               	shrq	$0x8, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x90(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x90(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x3800(%r10), %r11
               	movq	%r11, 0x88(%rsp)
               	movq	%r12, %r10
               	andq	$0xff, %r10
               	movq	0x88(%rsp), %r11
               	movq	(%r11,%r10,8), %r10
               	movq	0x90(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x90(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x88(%rsp)
               	movq	%r12, %r10
               	shrq	$0x38, %r10
               	movq	0x88(%rsp), %r11
               	movq	(%r11,%r10,8), %r11
               	movq	%r11, 0x88(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x800(%r10), %r11
               	movq	%rbx, %r10
               	shrq	$0x30, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x88(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x88(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1000(%r10), %r11
               	movq	%rdi, %r10
               	shrq	$0x28, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x88(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x88(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1800(%r10), %r11
               	movq	%rbp, %r10
               	shrq	$0x20, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x88(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x88(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x2000(%r10), %r11
               	movq	%rax, %r10
               	shrq	$0x18, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x88(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x88(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x2800(%r10), %r11
               	movq	%r15, %r10
               	shrq	$0x10, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x88(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x88(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x3000(%r10), %r11
               	movq	%r14, %r10
               	shrq	$0x8, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	movq	0x88(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x88(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	addq	$0x3800, %r10           # imm = 0x3800
               	movq	%r13, %r11
               	andq	$0xff, %r11
               	movq	(%r10,%r11,8), %r10
               	movq	0x88(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x88(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r13, %r11
               	shrq	$0x38, %r11
               	movq	(%r10,%r11,8), %r9
               	movq	%r9, 0x80(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x800(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%r12, %r10
               	shrq	$0x30, %r10
               	andq	$0xff, %r10
               	movq	0x78(%rsp), %r11
               	movq	(%r11,%r10,8), %r10
               	movq	0x80(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x80(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1000(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%rbx, %r10
               	shrq	$0x28, %r10
               	andq	$0xff, %r10
               	movq	0x78(%rsp), %r11
               	movq	(%r11,%r10,8), %r10
               	movq	0x80(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x80(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1800(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%rdi, %r10
               	shrq	$0x20, %r10
               	andq	$0xff, %r10
               	movq	0x78(%rsp), %r11
               	movq	(%r11,%r10,8), %r10
               	movq	0x80(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x80(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x2000(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%rbp, %r10
               	shrq	$0x18, %r10
               	andq	$0xff, %r10
               	movq	0x78(%rsp), %r11
               	movq	(%r11,%r10,8), %r10
               	movq	0x80(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x80(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x2800(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%rax, %r10
               	shrq	$0x10, %r10
               	andq	$0xff, %r10
               	movq	0x78(%rsp), %r11
               	movq	(%r11,%r10,8), %r10
               	movq	0x80(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x80(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x3000(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%r15, %r10
               	shrq	$0x8, %r10
               	andq	$0xff, %r10
               	movq	0x78(%rsp), %r11
               	movq	(%r11,%r10,8), %r10
               	movq	0x80(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x80(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x3800(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%r14, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %r11
               	movq	0x38(%rsp), %r9
               	movq	%r9, 0x30(%rsp)
               	movq	0x70(%rsp), %r9
               	movq	(%r11,%r9,8), %r10
               	movq	0x80(%rsp), %r11
               	xorq	%r10, %r11
               	movq	%r11, 0x80(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x78(%rsp)
               	movq	%r14, %r10
               	shrq	$0x38, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	0x70(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	addq	$0x800, %r10            # imm = 0x800
               	movq	%r10, 0x60(%rsp)
               	movq	%r13, %r10
               	shrq	$0x30, %r10
               	movq	%r10, 0x70(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	0x70(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %r10
               	xorq	0x70(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	addq	$0x1000, %r10           # imm = 0x1000
               	movq	%r10, 0x60(%rsp)
               	movq	%r12, %r10
               	shrq	$0x28, %r10
               	movq	%r10, 0x70(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	0x70(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %r10
               	xorq	0x70(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	addq	$0x1800, %r10           # imm = 0x1800
               	movq	%r10, 0x60(%rsp)
               	movq	%rbx, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x70(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	0x70(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %r10
               	xorq	0x70(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	addq	$0x2000, %r10           # imm = 0x2000
               	movq	%r10, 0x60(%rsp)
               	movq	%rdi, %r10
               	shrq	$0x18, %r10
               	movq	%r10, 0x70(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	0x70(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %r10
               	xorq	0x70(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	addq	$0x2800, %r10           # imm = 0x2800
               	movq	%r10, 0x60(%rsp)
               	movq	%rbp, %r10
               	shrq	$0x10, %r10
               	movq	%r10, 0x70(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	0x70(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %r10
               	xorq	0x70(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	addq	$0x3000, %r10           # imm = 0x3000
               	movq	%r10, 0x60(%rsp)
               	movq	%rax, %r10
               	shrq	$0x8, %r10
               	movq	%r10, 0x70(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	0x70(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %r10
               	xorq	0x70(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	addq	$0x3800, %r10           # imm = 0x3800
               	movq	%r10, 0x70(%rsp)
               	movq	%r15, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x70(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %r10
               	xorq	0x70(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	movq	%r15, %r10
               	shrq	$0x38, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x70(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x800, %r10            # imm = 0x800
               	movq	%r10, 0x50(%rsp)
               	movq	%r14, %r10
               	shrq	$0x30, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x70(%rsp), %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x1000, %r10           # imm = 0x1000
               	movq	%r10, 0x50(%rsp)
               	movq	%r13, %r10
               	shrq	$0x28, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x70(%rsp), %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x1800, %r10           # imm = 0x1800
               	movq	%r10, 0x50(%rsp)
               	movq	%r12, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x70(%rsp), %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x2000, %r10           # imm = 0x2000
               	movq	%r10, 0x50(%rsp)
               	movq	%rbx, %r10
               	shrq	$0x18, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x70(%rsp), %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x2800, %r10           # imm = 0x2800
               	movq	%r10, 0x50(%rsp)
               	movq	%rdi, %r10
               	shrq	$0x10, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x70(%rsp), %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x3000, %r10           # imm = 0x3000
               	movq	%r10, 0x50(%rsp)
               	movq	%rbp, %r10
               	shrq	$0x8, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x70(%rsp), %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x3800, %r10           # imm = 0x3800
               	movq	%r10, 0x60(%rsp)
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	0x50(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x70(%rsp), %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	shrq	$0x38, %rax
               	movq	0x60(%rsp), %r10
               	movq	(%r10,%rax,8), %rax
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x800, %r10            # imm = 0x800
               	movq	%r10, 0x60(%rsp)
               	shrq	$0x30, %r15
               	andq	$0xff, %r15
               	movq	0x60(%rsp), %r11
               	movq	(%r11,%r15,8), %r10
               	xorq	%r10, %rax
               	leaq	<rip>, %r10 # <addr>
               	addq	$0x1000, %r10           # imm = 0x1000
               	shrq	$0x28, %r14
               	andq	$0xff, %r14
               	movq	(%r10,%r14,8), %r10
               	xorq	%r10, %rax
               	leaq	<rip>, %r10 # <addr>
               	addq	$0x1800, %r10           # imm = 0x1800
               	shrq	$0x20, %r13
               	andq	$0xff, %r13
               	movq	(%r10,%r13,8), %r10
               	xorq	%r10, %rax
               	leaq	<rip>, %r10 # <addr>
               	addq	$0x2000, %r10           # imm = 0x2000
               	shrq	$0x18, %r12
               	andq	$0xff, %r12
               	movq	(%r10,%r12,8), %r10
               	xorq	%r10, %rax
               	leaq	<rip>, %r10 # <addr>
               	addq	$0x2800, %r10           # imm = 0x2800
               	shrq	$0x10, %rbx
               	andq	$0xff, %rbx
               	movq	(%r10,%rbx,8), %r10
               	xorq	%r10, %rax
               	leaq	<rip>, %r10 # <addr>
               	addq	$0x3000, %r10           # imm = 0x3000
               	shrq	$0x8, %rdi
               	andq	$0xff, %rdi
               	movq	(%r10,%rdi,8), %r10
               	xorq	%r10, %rax
               	leaq	<rip>, %r10 # <addr>
               	addq	$0x3800, %r10           # imm = 0x3800
               	andq	$0xff, %rbp
               	movq	(%r10,%rbp,8), %r10
               	xorq	%r10, %rax
               	leaq	<rip>, %r10 # <addr>
               	movq	0xb0(%rsp), %r11
               	shrq	$0x38, %r11
               	movq	(%r10,%r11,8), %r14
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x800(%r10), %r11
               	movq	%rcx, %r10
               	shrq	$0x30, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	xorq	%r10, %r14
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1000(%r10), %r11
               	movq	%rsi, %rdi
               	movq	%rdi, %r10
               	shrq	$0x28, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %r10
               	xorq	%r10, %r14
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x1800(%r10), %r11
               	movq	%rdx, %rbx
               	movq	%rbx, %r10
               	shrq	$0x20, %r10
               	andq	$0xff, %r10
               	movq	(%r11,%r10,8), %rdx
               	xorq	%rdx, %r14
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x2000, %rdx           # imm = 0x2000
               	movq	0x30(%rsp), %r9
               	movq	%r9, %r12
               	movq	%r12, %r9
               	shrq	$0x18, %r9
               	andq	$0xff, %r9
               	movq	(%rdx,%r9,8), %rdx
               	xorq	%rdx, %r14
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x2800, %rdx           # imm = 0x2800
               	movq	%r8, %r13
               	movq	%r13, %r8
               	shrq	$0x10, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %r14
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x3000, %rdx           # imm = 0x3000
               	movq	0xa0(%rsp), %r8
               	shrq	$0x8, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %r14
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x3800, %rdx           # imm = 0x3800
               	movq	0xa8(%rsp), %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %r14
               	xorq	0xb8(%rsp), %r14
               	leaq	<rip>, %rdx # <addr>
               	movq	0xa8(%rsp), %r8
               	shrq	$0x38, %r8
               	movq	(%rdx,%r8,8), %r15
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x800, %rdx            # imm = 0x800
               	movq	0xb0(%rsp), %r8
               	shrq	$0x30, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %r15
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x1000, %rdx           # imm = 0x1000
               	movq	%rcx, %r8
               	shrq	$0x28, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %r15
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x1800, %rdx           # imm = 0x1800
               	movq	%rdi, %r8
               	shrq	$0x20, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %r15
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x2000, %rdx           # imm = 0x2000
               	movq	%rbx, %r8
               	shrq	$0x18, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %r15
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x2800, %rdx           # imm = 0x2800
               	movq	%r12, %r8
               	shrq	$0x10, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %r15
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x3000, %rdx           # imm = 0x3000
               	movq	%r13, %r8
               	shrq	$0x8, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %r15
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x3800, %rdx           # imm = 0x3800
               	movq	0xa0(%rsp), %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %r15
               	xorq	0x98(%rsp), %r15
               	leaq	<rip>, %rdx # <addr>
               	movq	0xa0(%rsp), %r8
               	shrq	$0x38, %r8
               	movq	(%rdx,%r8,8), %rbp
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x800, %rdx            # imm = 0x800
               	movq	0xa8(%rsp), %r8
               	shrq	$0x30, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %rbp
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x1000, %rdx           # imm = 0x1000
               	movq	0xb0(%rsp), %r8
               	shrq	$0x28, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %rbp
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x1800, %rdx           # imm = 0x1800
               	movq	%rcx, %r8
               	shrq	$0x20, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %rbp
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x2000, %rdx           # imm = 0x2000
               	movq	%rdi, %r8
               	shrq	$0x18, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %rbp
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x2800, %rdx           # imm = 0x2800
               	movq	%rbx, %r8
               	shrq	$0x10, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %rbp
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x3000, %rdx           # imm = 0x3000
               	movq	%r12, %r8
               	shrq	$0x8, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %rbp
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x3800, %rdx           # imm = 0x3800
               	movq	%r13, %r8
               	andq	$0xff, %r8
               	movq	(%rdx,%r8,8), %rdx
               	xorq	%rdx, %rbp
               	xorq	0x90(%rsp), %rbp
               	leaq	<rip>, %rdx # <addr>
               	movq	%r13, %r8
               	shrq	$0x38, %r8
               	movq	(%rdx,%r8,8), %r8
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x800, %rdx            # imm = 0x800
               	movq	0xa0(%rsp), %r9
               	shrq	$0x30, %r9
               	andq	$0xff, %r9
               	movq	(%rdx,%r9,8), %rdx
               	xorq	%rdx, %r8
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x1000, %rdx           # imm = 0x1000
               	movq	0xa8(%rsp), %r9
               	shrq	$0x28, %r9
               	andq	$0xff, %r9
               	movq	(%rdx,%r9,8), %rdx
               	xorq	%rdx, %r8
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x1800, %rdx           # imm = 0x1800
               	movq	0xb0(%rsp), %r9
               	shrq	$0x20, %r9
               	andq	$0xff, %r9
               	movq	(%rdx,%r9,8), %rdx
               	xorq	%rdx, %r8
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x2000, %rdx           # imm = 0x2000
               	movq	%rcx, %r9
               	shrq	$0x18, %r9
               	andq	$0xff, %r9
               	movq	(%rdx,%r9,8), %rdx
               	xorq	%rdx, %r8
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x2800, %rdx           # imm = 0x2800
               	movq	%rdi, %r9
               	shrq	$0x10, %r9
               	andq	$0xff, %r9
               	movq	(%rdx,%r9,8), %rdx
               	xorq	%rdx, %r8
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x3000, %rdx           # imm = 0x3000
               	movq	%rbx, %r9
               	shrq	$0x8, %r9
               	andq	$0xff, %r9
               	movq	(%rdx,%r9,8), %rdx
               	xorq	%rdx, %r8
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x3800, %rdx           # imm = 0x3800
               	movq	%r12, %r9
               	andq	$0xff, %r9
               	movq	(%rdx,%r9,8), %rdx
               	xorq	%rdx, %r8
               	xorq	0x88(%rsp), %r8
               	leaq	<rip>, %rdx # <addr>
               	movq	%r12, %r9
               	shrq	$0x38, %r9
               	movq	(%rdx,%r9,8), %r9
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x800, %rdx            # imm = 0x800
               	movq	%r13, %r10
               	shrq	$0x30, %r10
               	andq	$0xff, %r10
               	movq	(%rdx,%r10,8), %rdx
               	xorq	%rdx, %r9
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x1000, %rdx           # imm = 0x1000
               	movq	0xa0(%rsp), %r10
               	shrq	$0x28, %r10
               	andq	$0xff, %r10
               	movq	(%rdx,%r10,8), %rdx
               	xorq	%rdx, %r9
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x1800, %rdx           # imm = 0x1800
               	movq	0xa8(%rsp), %r10
               	shrq	$0x20, %r10
               	andq	$0xff, %r10
               	movq	(%rdx,%r10,8), %rdx
               	xorq	%rdx, %r9
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x2000, %rdx           # imm = 0x2000
               	movq	0xb0(%rsp), %r10
               	shrq	$0x18, %r10
               	andq	$0xff, %r10
               	movq	(%rdx,%r10,8), %rdx
               	xorq	%rdx, %r9
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x2800, %rdx           # imm = 0x2800
               	movq	%rcx, %r10
               	shrq	$0x10, %r10
               	andq	$0xff, %r10
               	movq	(%rdx,%r10,8), %rdx
               	xorq	%rdx, %r9
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x3000, %rdx           # imm = 0x3000
               	movq	%rdi, %r10
               	shrq	$0x8, %r10
               	andq	$0xff, %r10
               	movq	(%rdx,%r10,8), %rdx
               	xorq	%rdx, %r9
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x3800, %rdx           # imm = 0x3800
               	movq	%rbx, %r10
               	andq	$0xff, %r10
               	movq	(%rdx,%r10,8), %rdx
               	xorq	%rdx, %r9
               	xorq	0x80(%rsp), %r9
               	leaq	<rip>, %rdx # <addr>
               	movq	%rbx, %r10
               	shrq	$0x38, %r10
               	movq	(%rdx,%r10,8), %rdx
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x800(%rsi), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%r12, %rsi
               	shrq	$0x30, %rsi
               	andq	$0xff, %rsi
               	movq	0x60(%rsp), %r11
               	movq	(%r11,%rsi,8), %r10
               	xorq	%r10, %rdx
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x1000(%rsi), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%r13, %rsi
               	shrq	$0x28, %rsi
               	andq	$0xff, %rsi
               	movq	0x60(%rsp), %r11
               	movq	(%r11,%rsi,8), %r10
               	xorq	%r10, %rdx
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x1800(%rsi), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0xa0(%rsp), %rsi
               	shrq	$0x20, %rsi
               	andq	$0xff, %rsi
               	movq	0x60(%rsp), %r11
               	movq	(%r11,%rsi,8), %r10
               	xorq	%r10, %rdx
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x2000(%rsi), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0xa8(%rsp), %rsi
               	shrq	$0x18, %rsi
               	andq	$0xff, %rsi
               	movq	0x60(%rsp), %r11
               	movq	(%r11,%rsi,8), %r10
               	xorq	%r10, %rdx
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x2800(%rsi), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0xb0(%rsp), %rsi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movq	0x60(%rsp), %r11
               	movq	(%r11,%rsi,8), %r10
               	xorq	%r10, %rdx
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x3000(%rsi), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%rcx, %rsi
               	shrq	$0x8, %rsi
               	andq	$0xff, %rsi
               	movq	0x60(%rsp), %r11
               	movq	(%r11,%rsi,8), %r10
               	xorq	%r10, %rdx
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x3800(%r10), %rsi
               	movq	%rdi, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%r10, %r11
               	movq	(%rsi,%r11,8), %r10
               	xorq	%r10, %rdx
               	xorq	0x78(%rsp), %rdx
               	leaq	<rip>, %rsi # <addr>
               	movq	%rdi, %r10
               	shrq	$0x38, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	(%rsi,%r10,8), %rsi
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x800, %r10            # imm = 0x800
               	movq	%r10, 0x50(%rsp)
               	movq	%rbx, %r10
               	shrq	$0x30, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	xorq	0x60(%rsp), %rsi
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x1000, %r10           # imm = 0x1000
               	movq	%r10, 0x50(%rsp)
               	movq	%r12, %r10
               	shrq	$0x28, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	xorq	0x60(%rsp), %rsi
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x1800, %r10           # imm = 0x1800
               	movq	%r10, 0x50(%rsp)
               	movq	%r13, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	xorq	0x60(%rsp), %rsi
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x2000, %r10           # imm = 0x2000
               	movq	%r10, 0x50(%rsp)
               	movq	0xa0(%rsp), %r10
               	shrq	$0x18, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	xorq	0x60(%rsp), %rsi
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x2800, %r10           # imm = 0x2800
               	movq	%r10, 0x50(%rsp)
               	movq	0xa8(%rsp), %r10
               	shrq	$0x10, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	xorq	0x60(%rsp), %rsi
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x3000, %r10           # imm = 0x3000
               	movq	%r10, 0x50(%rsp)
               	movq	0xb0(%rsp), %r10
               	shrq	$0x8, %r10
               	movq	%r10, 0x60(%rsp)
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	xorq	0x60(%rsp), %rsi
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x3800, %r10           # imm = 0x3800
               	movq	%r10, 0x60(%rsp)
               	movq	%rcx, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	0x50(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	xorq	0x60(%rsp), %rsi
               	xorq	0x70(%rsp), %rsi
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	shrq	$0x38, %rcx
               	movq	0x60(%rsp), %r10
               	movq	(%r10,%rcx,8), %rcx
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	addq	$0x800, %r10            # imm = 0x800
               	movq	%r10, 0x60(%rsp)
               	shrq	$0x30, %rdi
               	andq	$0xff, %rdi
               	movq	0x60(%rsp), %r11
               	movq	(%r11,%rdi,8), %r10
               	xorq	%r10, %rcx
               	leaq	<rip>, %r10 # <addr>
               	addq	$0x1000, %r10           # imm = 0x1000
               	shrq	$0x28, %rbx
               	andq	$0xff, %rbx
               	movq	(%r10,%rbx,8), %r10
               	xorq	%r10, %rcx
               	leaq	<rip>, %r10 # <addr>
               	addq	$0x1800, %r10           # imm = 0x1800
               	shrq	$0x20, %r12
               	andq	$0xff, %r12
               	movq	(%r10,%r12,8), %r10
               	xorq	%r10, %rcx
               	leaq	<rip>, %r10 # <addr>
               	addq	$0x2000, %r10           # imm = 0x2000
               	shrq	$0x18, %r13
               	andq	$0xff, %r13
               	movq	(%r10,%r13,8), %r10
               	xorq	%r10, %rcx
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x2800(%r10), %rdi
               	movq	0xa0(%rsp), %r10
               	shrq	$0x10, %r10
               	andq	$0xff, %r10
               	movq	(%rdi,%r10,8), %r10
               	xorq	%r10, %rcx
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x3000(%r10), %rdi
               	movq	0xa8(%rsp), %r10
               	shrq	$0x8, %r10
               	andq	$0xff, %r10
               	movq	(%rdi,%r10,8), %r10
               	xorq	%r10, %rcx
               	leaq	<rip>, %r10 # <addr>
               	leaq	0x3800(%r10), %rdi
               	movq	0xb0(%rsp), %r10
               	andq	$0xff, %r10
               	movq	(%rdi,%r10,8), %r10
               	xorq	%r10, %rcx
               	xorq	%rax, %rcx
               	addq	$0x1, 0x68(%rsp)
               	movq	%r14, 0xb0(%rsp)
               	movq	%r15, 0xa8(%rsp)
               	movq	0x78(%rsp), %r14
               	movq	0x80(%rsp), %r13
               	movq	0x88(%rsp), %r12
               	movq	0x90(%rsp), %rbx
               	movq	0x98(%rsp), %rdi
               	movq	%rbp, 0xa0(%rsp)
               	movq	0x70(%rsp), %r15
               	movq	0xb8(%rsp), %rbp
               	nop
               	movq	0x68(%rsp), %r10
               	cmpl	$0xa, %r10d
               	jl	<addr>
               	movq	0x48(%rsp), %rax
               	movq	(%rax), %r10
               	movq	0x40(%rsp), %rdi
               	movq	(%rdi), %r11
               	movq	0xb0(%rsp), %r15
               	xorq	%r11, %r15
               	movq	%r15, 0xb0(%rsp)
               	xorq	0xb0(%rsp), %r10
               	movq	%r10, (%rax)
               	movq	0x8(%rax), %r10
               	movq	0x8(%rdi), %r11
               	movq	0xa8(%rsp), %r15
               	xorq	%r11, %r15
               	movq	%r15, 0xa8(%rsp)
               	xorq	0xa8(%rsp), %r10
               	movq	%r10, 0x8(%rax)
               	movq	0x10(%rax), %r10
               	movq	0x10(%rdi), %r11
               	movq	0xa0(%rsp), %r15
               	xorq	%r11, %r15
               	movq	%r15, 0xa0(%rsp)
               	xorq	0xa0(%rsp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	0x18(%rax), %r10
               	movq	0x18(%rdi), %r11
               	xorq	%r11, %r8
               	xorq	%r8, %r10
               	movq	%r10, 0x18(%rax)
               	movq	0x20(%rax), %r8
               	movq	0x20(%rdi), %r10
               	xorq	%r10, %r9
               	xorq	%r9, %r8
               	movq	%r8, 0x20(%rax)
               	movq	0x28(%rax), %r8
               	movq	0x28(%rdi), %r9
               	xorq	%r9, %rdx
               	xorq	%rdx, %r8
               	movq	%r8, 0x28(%rax)
               	movq	0x30(%rax), %rdx
               	movq	0x30(%rdi), %r8
               	xorq	%r8, %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rax), %rdx
               	movq	0x38(%rdi), %rsi
               	xorq	%rsi, %rcx
               	xorq	%rcx, %rdx
               	movq	%rdx, 0x38(%rax)
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x98, %rsp
               	retq

<main>:
               	subq	$0xd8, %rsp
               	movabsq	$0x101010101010101, %rax # imm = 0x101010101010101
               	movq	%rax, (%rsp)
               	movabsq	$0x807060504030201, %rax # imm = 0x807060504030201
               	movq	%rax, 0x40(%rsp)
               	movabsq	$0x202020202020202, %rax # imm = 0x202020202020202
               	movq	%rax, 0x8(%rsp)
               	movabsq	$0x100e0c0a08060402, %rax # imm = 0x100E0C0A08060402
               	movq	%rax, 0x48(%rsp)
               	movabsq	$0x303030303030303, %rax # imm = 0x303030303030303
               	movq	%rax, 0x10(%rsp)
               	movabsq	$0x201c1814100c0804, %rax # imm = 0x201C1814100C0804
               	movq	%rax, 0x50(%rsp)
               	movabsq	$0x404040404040404, %rax # imm = 0x404040404040404
               	movq	%rax, 0x18(%rsp)
               	movabsq	$0x4038302820181008, %rax # imm = 0x4038302820181008
               	movq	%rax, 0x58(%rsp)
               	movabsq	$0x505050505050505, %rax # imm = 0x505050505050505
               	movq	%rax, 0x20(%rsp)
               	movabsq	$-0x7f8f9fafbfcfdff0, %rax # imm = 0x8070605040302010
               	movq	%rax, 0x60(%rsp)
               	movabsq	$0x606060606060606, %rax # imm = 0x606060606060606
               	movq	%rax, 0x28(%rsp)
               	movabsq	$0xe0c0a080604020, %rax # imm = 0xE0C0A080604020
               	movq	%rax, 0x68(%rsp)
               	movabsq	$0x707070707070707, %rax # imm = 0x707070707070707
               	movq	%rax, 0x30(%rsp)
               	movabsq	$0x1c1814100c08040, %rax # imm = 0x1C1814100C08040
               	movq	%rax, 0x70(%rsp)
               	movabsq	$0x808080808080808, %rax # imm = 0x808080808080808
               	movq	%rax, 0x38(%rsp)
               	movabsq	$0x383028201810080, %rax # imm = 0x383028201810080
               	movq	%rax, 0x78(%rsp)
               	movabsq	$0x5a5a5a5a5a5a5a5a, %rax # imm = 0x5A5A5A5A5A5A5A5A
               	movq	%rax, 0x80(%rsp)
               	movabsq	$0x2d2d2d2d2d2d2d2d, %rax # imm = 0x2D2D2D2D2D2D2D2D
               	movq	%rax, 0x88(%rsp)
               	movabsq	$0x1696969696969696, %rax # imm = 0x1696969696969696
               	movq	%rax, 0x90(%rsp)
               	movabsq	$0xb4b4b4b4b4b4b4b, %rax # imm = 0xB4B4B4B4B4B4B4B
               	movq	%rax, 0x98(%rsp)
               	movabsq	$0x5a5a5a5a5a5a5a5, %rax # imm = 0x5A5A5A5A5A5A5A5
               	movq	%rax, 0xa0(%rsp)
               	movabsq	$0x2d2d2d2d2d2d2d2, %rax # imm = 0x2D2D2D2D2D2D2D2
               	movq	%rax, 0xa8(%rsp)
               	movabsq	$0x169696969696969, %rax # imm = 0x169696969696969
               	movq	%rax, 0xb0(%rsp)
               	movabsq	$0xb4b4b4b4b4b4b4, %rax # imm = 0xB4B4B4B4B4B4B4
               	movq	%rax, 0xb8(%rsp)
               	movabsq	$0x5a5a5a5a5a5a5a, %rax # imm = 0x5A5A5A5A5A5A5A
               	movq	%rax, 0xc0(%rsp)
               	movabsq	$0x2d2d2d2d2d2d2d, %rax # imm = 0x2D2D2D2D2D2D2D
               	movq	%rax, 0xc8(%rsp)
               	leaq	(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	leaq	0x80(%rsp), %rdx
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	leaq	0x80(%rsp), %rdx
               	callq	<addr>
               	movq	(%rsp), %rax
               	imulq	$0x1f, %rax, %rax
               	movq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	movq	0x10(%rsp), %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	movq	0x28(%rsp), %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	movq	0x30(%rsp), %rcx
               	addq	%rcx, %rax
               	imulq	$0x1f, %rax, %rax
               	movq	0x38(%rsp), %rcx
               	addq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	movabsq	$0x515151514a736c84, %r11 # imm = 0x515151514A736C84
               	cmpq	%r11, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0xd8, %rsp
               	retq
