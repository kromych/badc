
ssa_call_result_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<rot>:
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	rorq	%cl, %rax
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
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0x100, %r10d           # imm = 0x100
               	movq	%r10, 0x40(%rsp)
               	movl	$0x200, %r10d           # imm = 0x200
               	movq	%r10, 0x48(%rsp)
               	movl	$0x400, %r10d           # imm = 0x400
               	movq	%r10, 0x50(%rsp)
               	movl	$0x800, %r10d           # imm = 0x800
               	movq	%r10, 0x58(%rsp)
               	movl	$0x1000, %r15d          # imm = 0x1000
               	movl	$0x2000, %r14d          # imm = 0x2000
               	movl	$0x4000, %r13d          # imm = 0x4000
               	movl	$0x8000, %r12d          # imm = 0x8000
               	xorq	%rbx, %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	incq	%rbx
               	movq	%r13, %r12
               	movq	%r14, %r13
               	movq	%r15, %r14
               	movq	%rcx, %r15
               	movq	0x50(%rsp), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	0x48(%rsp), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x40(%rsp), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%rdx, 0x40(%rsp)
               	jmp	<addr>
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	%r15, %rdi
               	movq	%r13, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x38(%rsp), %rax
               	addq	%r10, %rax
               	addq	%rax, %r12
               	movq	0x40(%rsp), %rdi
               	callq	<addr>
               	movq	0x58(%rsp), %rcx
               	addq	%r12, %rcx
               	leaq	(%r12,%rax), %rdx
               	jmp	<addr>
               	movq	0x40(%rsp), %rax
               	movabsq	$0x30a55d88de61bb19, %r11 # imm = 0x30A55D88DE61BB19
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x440000080000c800, %r11 # imm = 0x440000080000C800
               	movq	%r12, %rax
               	cmpq	%r11, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
