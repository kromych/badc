
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
               	pushq	%rcx
               	movq	%rsi, %rcx
               	rorq	%cl, %rax
               	popq	%rcx
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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0x100, %r13d           # imm = 0x100
               	movl	$0x200, %r12d           # imm = 0x200
               	movl	$0x400, %ebx            # imm = 0x400
               	movl	$0x800, %r9d            # imm = 0x800
               	movl	$0x1000, %r8d           # imm = 0x1000
               	movl	$0x2000, %edi           # imm = 0x2000
               	movl	$0x4000, %esi           # imm = 0x4000
               	movl	$0x8000, %edx           # imm = 0x8000
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movq	%r8, %rax
               	rorq	$0xe, %rax
               	movq	%r8, %r14
               	rorq	$0x12, %r14
               	xorq	%r14, %rax
               	movq	%r8, %r14
               	rorq	$0x29, %r14
               	xorq	%r14, %rax
               	movq	%r8, %r14
               	andq	%rdi, %r14
               	movq	%r8, %r15
               	xorq	$-0x1, %r15
               	andq	%rsi, %r15
               	xorq	%r15, %r14
               	addq	%r14, %rax
               	addq	%rdx, %rax
               	movq	%r13, %rdx
               	rorq	$0xe, %rdx
               	movq	%r13, %r14
               	rorq	$0x12, %r14
               	xorq	%r14, %rdx
               	movq	%r13, %r14
               	rorq	$0x29, %r14
               	xorq	%r14, %rdx
               	addq	%rax, %r9
               	addq	%rax, %rdx
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	xchgq	%rsi, %rdx
               	xchgq	%rsi, %r13
               	xchgq	%rsi, %r12
               	xchgq	%rsi, %rbx
               	xchgq	%rsi, %r9
               	xchgq	%rsi, %r8
               	xchgq	%rsi, %rdi
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	movabsq	$0x30a55d88de61bb19, %r11 # imm = 0x30A55D88DE61BB19
               	movq	%r13, %rax
               	cmpq	%r11, %r13
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x440000080000c800, %r11 # imm = 0x440000080000C800
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
