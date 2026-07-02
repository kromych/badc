
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
               	movl	$0xe, %eax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	rorq	%cl, %rax
               	popq	%rcx
               	movl	$0x12, %ecx
               	movslq	%ecx, %rcx
               	movq	%rcx, %r10
               	movq	%rdi, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	rorq	%cl, %r11
               	movq	%r11, %rcx
               	xorq	%rcx, %rax
               	movl	$0x29, %ecx
               	movslq	%ecx, %rcx
               	movq	%rcx, %r10
               	movq	%rdi, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	rorq	%cl, %r11
               	movq	%r11, %rcx
               	xorq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
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
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	xchgq	%rsi, %rdx
               	xchgq	%rsi, %r13
               	xchgq	%rsi, %r12
               	xchgq	%rsi, %rbx
               	xchgq	%rsi, %r9
               	xchgq	%rsi, %r8
               	xchgq	%rsi, %rdi
               	jmp	<addr>
               	movl	$0xe, %eax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r8, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	rorq	%cl, %rax
               	popq	%rcx
               	movl	$0x12, %r14d
               	movslq	%r14d, %r14
               	movq	%r14, %r10
               	movq	%r8, %r14
               	pushq	%rcx
               	movq	%r10, %rcx
               	rorq	%cl, %r14
               	popq	%rcx
               	xorq	%r14, %rax
               	movl	$0x29, %r14d
               	movslq	%r14d, %r14
               	movq	%r14, %r10
               	movq	%r8, %r14
               	pushq	%rcx
               	movq	%r10, %rcx
               	rorq	%cl, %r14
               	popq	%rcx
               	xorq	%r14, %rax
               	movq	%r8, %r14
               	andq	%rdi, %r14
               	movq	%r8, %r15
               	xorq	$-0x1, %r15
               	andq	%rsi, %r15
               	xorq	%r15, %r14
               	addq	%r14, %rax
               	addq	%rdx, %rax
               	movl	$0xe, %edx
               	movslq	%edx, %rdx
               	movq	%rdx, %r10
               	movq	%r13, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	rorq	%cl, %rdx
               	popq	%rcx
               	movl	$0x12, %r14d
               	movslq	%r14d, %r14
               	movq	%r14, %r10
               	movq	%r13, %r14
               	pushq	%rcx
               	movq	%r10, %rcx
               	rorq	%cl, %r14
               	popq	%rcx
               	xorq	%r14, %rdx
               	movl	$0x29, %r14d
               	movslq	%r14d, %r14
               	movq	%r14, %r10
               	movq	%r13, %r14
               	pushq	%rcx
               	movq	%r10, %rcx
               	rorq	%cl, %r14
               	popq	%rcx
               	xorq	%r14, %rdx
               	addq	%rax, %r9
               	addq	%rax, %rdx
               	jmp	<addr>
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
               	addq	$0xb0, %rsp
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
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
