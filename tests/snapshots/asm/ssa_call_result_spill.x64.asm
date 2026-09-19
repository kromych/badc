
ssa_call_result_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x100, %r13d           # imm = 0x100
               	movl	$0x200, %r10d           # imm = 0x200
               	movq	%r10, 0x40(%rsp)
               	movl	$0x400, %r10d           # imm = 0x400
               	movq	%r10, 0x48(%rsp)
               	movl	$0x800, %r10d           # imm = 0x800
               	movq	%r10, 0x50(%rsp)
               	movl	$0x1000, %r12d          # imm = 0x1000
               	movl	$0x2000, %r15d          # imm = 0x2000
               	movl	$0x4000, %r14d          # imm = 0x4000
               	movl	$0x8000, %r10d          # imm = 0x8000
               	movq	%r10, 0x58(%rsp)
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%r12, %rdi
               	callq	*%rax
               	movq	%rax, 0x38(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%r12, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	callq	*%rax
               	movq	%rax, %r10
               	movq	0x38(%rsp), %rax
               	addq	%r10, %rax
               	movq	%rax, %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%r13, %rdi
               	callq	*%rax
               	movq	0x58(%rsp), %rcx
               	movq	0x50(%rsp), %rdx
               	addq	%rcx, %rdx
               	addq	%rcx, %rax
               	incq	%rbx
               	movq	%r14, 0x58(%rsp)
               	movq	%r15, %r14
               	movq	%r12, %r15
               	movq	%rdx, %r12
               	movq	0x48(%rsp), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x40(%rsp), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%r13, 0x40(%rsp)
               	movq	%rax, %r13
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movabsq	$0x30a55d88de61bb19, %r11 # imm = 0x30A55D88DE61BB19
               	movq	%r13, %rax
               	cmpq	%r11, %r13
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x58(%rsp), %rax
               	movabsq	$0x440000080000c800, %r11 # imm = 0x440000080000C800
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
