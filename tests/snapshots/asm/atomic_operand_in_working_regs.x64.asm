
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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdx, %rbx
               	movq	%rcx, %r12
               	movl	$0x64, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	<rip>, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x5, %edx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rdx, %r10
               	movq	(%rcx), %rax
               	lock
               	cmpxchgq	%r10, (%r11)
               	je	<addr>
               	movq	%rax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rcx
               	leaq	(%rdi,%rsi), %rdx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rdx, %r10
               	movq	%r10, %rax
               	lock
               	xaddq	%rax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %r13
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	cmpq	$0x9, %r13
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	(%rax), %rax
               	leaq	0x9(%rdi), %rcx
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	(%rdx,%rbx), %rax
               	addq	%r12, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
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
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	%eax, %rax
               	jmp	<addr>
