
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0x100, %ecx            # imm = 0x100
               	movl	$0x200, %r12d           # imm = 0x200
               	movl	$0x400, %ebx            # imm = 0x400
               	movl	$0x800, %r9d            # imm = 0x800
               	movl	$0x1000, %eax           # imm = 0x1000
               	movl	$0x2000, %edi           # imm = 0x2000
               	movl	$0x4000, %esi           # imm = 0x4000
               	movl	$0x8000, %r8d           # imm = 0x8000
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movq	%rax, %r14
               	rorq	$0xe, %r14
               	movq	%rax, %r15
               	rorq	$0x12, %r15
               	xorq	%r15, %r14
               	movq	%rax, %r15
               	rorq	$0x29, %r15
               	xorq	%r15, %r14
               	movq	%rax, %r15
               	andq	%rdi, %r15
               	movq	%rax, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	andq	%rsi, %r10
               	movq	%r10, 0x38(%rsp)
               	xorq	0x38(%rsp), %r15
               	addq	%r15, %r14
               	addq	%r14, %r8
               	movq	%rcx, %r14
               	rorq	$0xe, %r14
               	movq	%rcx, %r15
               	rorq	$0x12, %r15
               	xorq	%r15, %r14
               	movq	%rcx, %r15
               	rorq	$0x29, %r15
               	xorq	%r15, %r14
               	addq	%r8, %r9
               	addq	%r14, %r8
               	leaq	0x1(%r13), %rdx
               	xchgq	%rsi, %r8
               	xchgq	%rsi, %rcx
               	xchgq	%rsi, %r12
               	xchgq	%rsi, %rbx
               	xchgq	%rsi, %r9
               	xchgq	%rsi, %rax
               	xchgq	%rsi, %rdi
               	movslq	%edx, %r13
               	cmpq	$0x4, %r13
               	jl	<addr>
               	movabsq	$0x30a55d88de61bb19, %r11 # imm = 0x30A55D88DE61BB19
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x440000080000c800, %r11 # imm = 0x440000080000C800
               	movq	%r8, %rax
               	cmpq	%r11, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
