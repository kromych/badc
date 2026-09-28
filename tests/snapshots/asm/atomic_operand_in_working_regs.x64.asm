
atomic_operand_in_working_regs.x64:	file format elf64-x86-64

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

<f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %rbx
               	movq	%rcx, %r12
               	movl	$0x64, %eax
               	leaq	<rip>, %rdx
               	movl	$0x5, %ecx
               	pushq	%rax
               	lock
               	cmpxchgq	%rcx, (%rdx)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	cmpq	$0x64, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rcx
               	leaq	(%rdi,%rsi), %r13
               	movq	%r13, %r10
               	lock
               	xaddq	%r10, (%rcx)
               	movq	%r10, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	0x9(%rdi), %rcx
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	(%rdi,%rsi), %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %eax
               	movl	$0x8, %ebx
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x24, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
