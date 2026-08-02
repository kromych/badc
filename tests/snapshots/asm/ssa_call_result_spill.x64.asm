
ssa_call_result_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	popq	%rdx
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rdi
               	leaq	-0x40(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r9
               	leaq	-0x40(%rbp), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rbx
               	leaq	-0x40(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rcx
               	leaq	-0x40(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	leaq	-0x40(%rbp), %rdx
               	addq	$0x28, %rdx
               	movq	(%rdx), %r8
               	leaq	-0x40(%rbp), %rdx
               	addq	$0x30, %rdx
               	movq	(%rdx), %rsi
               	leaq	-0x40(%rbp), %rdx
               	addq	$0x38, %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %r12
               	rorq	$0xe, %r12
               	movq	%rax, %r13
               	rorq	$0x12, %r13
               	xorq	%r13, %r12
               	movq	%rax, %r13
               	rorq	$0x29, %r13
               	xorq	%r13, %r12
               	movq	%rax, %r13
               	andq	%r8, %r13
               	movq	%rax, %r14
               	xorq	$-0x1, %r14
               	andq	%rsi, %r14
               	xorq	%r14, %r13
               	addq	%r13, %r12
               	addq	%r12, %rdx
               	movq	%rdi, %r12
               	rorq	$0xe, %r12
               	movq	%rdi, %r13
               	rorq	$0x12, %r13
               	xorq	%r13, %r12
               	movq	%rdi, %r13
               	rorq	$0x29, %r13
               	xorq	%r13, %r12
               	addq	%rdx, %rcx
               	addq	%r12, %rdx
               	movq	%rcx, %r12
               	rorq	$0xe, %r12
               	movq	%rcx, %r13
               	rorq	$0x12, %r13
               	xorq	%r13, %r12
               	movq	%rcx, %r13
               	rorq	$0x29, %r13
               	xorq	%r13, %r12
               	movq	%rcx, %r13
               	andq	%rax, %r13
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	andq	%r8, %r14
               	xorq	%r14, %r13
               	addq	%r13, %r12
               	addq	%r12, %rsi
               	movq	%rdx, %r12
               	rorq	$0xe, %r12
               	movq	%rdx, %r13
               	rorq	$0x12, %r13
               	xorq	%r13, %r12
               	rorq	$0x29, %rdx
               	xorq	%rdx, %r12
               	leaq	(%rbx,%rsi), %rdx
               	addq	%r12, %rsi
               	movq	%rdx, %rbx
               	rorq	$0xe, %rbx
               	movq	%rdx, %r12
               	rorq	$0x12, %r12
               	xorq	%r12, %rbx
               	movq	%rdx, %r12
               	rorq	$0x29, %r12
               	xorq	%r12, %rbx
               	movq	%rdx, %r12
               	andq	%rcx, %r12
               	movq	%rdx, %r13
               	xorq	$-0x1, %r13
               	andq	%rax, %r13
               	xorq	%r13, %r12
               	addq	%r12, %rbx
               	addq	%rbx, %r8
               	movq	%rsi, %rbx
               	rorq	$0xe, %rbx
               	movq	%rsi, %r12
               	rorq	$0x12, %r12
               	xorq	%r12, %rbx
               	rorq	$0x29, %rsi
               	xorq	%rsi, %rbx
               	leaq	(%r9,%r8), %rsi
               	addq	%rbx, %r8
               	movq	%rsi, %r9
               	rorq	$0xe, %r9
               	movq	%rsi, %rbx
               	rorq	$0x12, %rbx
               	xorq	%rbx, %r9
               	movq	%rsi, %rbx
               	rorq	$0x29, %rbx
               	xorq	%rbx, %r9
               	andq	%rsi, %rdx
               	xorq	$-0x1, %rsi
               	andq	%rcx, %rsi
               	xorq	%rsi, %rdx
               	addq	%r9, %rdx
               	addq	%rdx, %rax
               	movq	%r8, %rdx
               	rorq	$0xe, %rdx
               	movq	%r8, %rsi
               	rorq	$0x12, %rsi
               	xorq	%rsi, %rdx
               	movq	%r8, %rsi
               	rorq	$0x29, %rsi
               	xorq	%rsi, %rdx
               	addq	%rdx, %rax
               	movabsq	$0x30a55d88de61bb19, %r11 # imm = 0x30A55D88DE61BB19
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x440000080000c800, %r11 # imm = 0x440000080000C800
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
