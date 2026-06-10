
ssa_call_result_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<rot>:
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	shrq	%cl, %rax
               	movl	$0x40, %ecx
               	subq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %r10
               	movq	%rdi, %rcx
               	movq	%rcx, %r13
               	movq	%r10, %rcx
               	shlq	%cl, %r13
               	movq	%r13, %rcx
               	orq	%rcx, %rax
               	retq

<ch>:
               	movq	%rdi, %rax
               	andq	%rsi, %rax
               	movq	%rdi, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rdx, %rcx
               	xorq	%rcx, %rax
               	retq

<bs1>:
               	movq	%rdi, %rax
               	rorq	$0xe, %rax
               	movq	%rdi, %rcx
               	rorq	$0x12, %rcx
               	xorq	%rcx, %rax
               	movq	%rdi, %rcx
               	rorq	$0x29, %rcx
               	xorq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x100, %r10d           # imm = 0x100
               	movq	%r10, 0x28(%rsp)
               	movl	$0x200, %r10d           # imm = 0x200
               	movq	%r10, 0x30(%rsp)
               	movl	$0x400, %r10d           # imm = 0x400
               	movq	%r10, 0x38(%rsp)
               	movl	$0x800, %r10d           # imm = 0x800
               	movq	%r10, 0x40(%rsp)
               	movl	$0x1000, %r10d          # imm = 0x1000
               	movq	%r10, 0x48(%rsp)
               	movl	$0x2000, %r15d          # imm = 0x2000
               	movl	$0x4000, %r14d          # imm = 0x4000
               	movl	$0x8000, %r12d          # imm = 0x8000
               	xorq	%rbx, %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	incq	%rbx
               	movq	%r14, %r12
               	movq	%r15, %r14
               	movq	0x48(%rsp), %r15
               	movq	%rcx, 0x48(%rsp)
               	movq	0x38(%rsp), %r13
               	movq	%r13, 0x40(%rsp)
               	movq	0x30(%rsp), %r13
               	movq	%r13, 0x38(%rsp)
               	movq	0x28(%rsp), %r13
               	movq	%r13, 0x30(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	jmp	<addr>
               	movq	0x48(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, 0x20(%rsp)
               	movq	%r15, %rsi
               	movq	%r14, %rdx
               	movq	0x48(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x20(%rsp), %rax
               	addq	%r10, %rax
               	addq	%rax, %r12
               	movq	0x28(%rsp), %rdi
               	callq	<addr>
               	movq	0x40(%rsp), %rcx
               	addq	%r12, %rcx
               	movq	%r12, %rdx
               	addq	%rax, %rdx
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	movabsq	$0x30a55d88de61bb19, %r13 # imm = 0x30A55D88DE61BB19
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x440000080000c800, %r13 # imm = 0x440000080000C800
               	movq	%r12, %rax
               	cmpq	%r13, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
