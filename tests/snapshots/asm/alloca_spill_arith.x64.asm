
alloca_spill_arith.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x10000, %eax          # imm = 0x10000
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movzbq	<rip>, %rcx # <addr>
               	movb	%cl, (%rax)
               	movzbq	<rip>, %rcx # <addr>
               	movb	%cl, 0x1(%rax)
               	movzbq	<rip>, %rcx # <addr>
               	movb	%cl, 0x2(%rax)
               	movzbq	<rip>, %rcx # <addr>
               	movb	%cl, 0x3(%rax)
               	movzbq	<rip>, %rcx # <addr>
               	movb	%cl, 0x4(%rax)
               	movzbq	<rip>, %rcx # <addr>
               	movb	%cl, 0x5(%rax)
               	leaq	0xffff(%rax), %rcx
               	movzbq	<rip>, %rdx # <addr>
               	movb	%dl, (%rcx)
               	movzbq	(%rax), %r13
               	movzbq	0x1(%rax), %r10
               	movzbq	0x2(%rax), %r11
               	movzbq	0x3(%rax), %rbx
               	movzbq	0x4(%rax), %r12
               	movzbq	0x5(%rax), %r14
               	leaq	(%r13,%r10), %rdx
               	leaq	(%r11,%rbx), %rcx
               	leaq	(%r12,%r14), %rsi
               	leaq	(%rdx,%rdx,2), %rdi
               	leaq	(%rcx,%rcx,4), %r8
               	imulq	$0x7, %rsi, %r9
               	cmpl	%ecx, %edx
               	movq	%r8, %r15
               	cmovlq	%rdi, %r15
               	movq	%r10, -0x30(%rbp)
               	cmpl	%esi, %ecx
               	movq	%r9, %r10
               	cmovlq	%r8, %r10
               	movq	%r10, -0x18(%rbp)
               	movq	-0x30(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	cmpl	%edx, %esi
               	movq	%rdi, %r10
               	cmovlq	%r9, %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x30(%rbp), %r10
               	movq	%r11, -0x30(%rbp)
               	leaq	(%r13,%r10), %r11
               	movq	%r11, -0x28(%rbp)
               	movq	-0x30(%rbp), %r11
               	movq	%r10, -0x30(%rbp)
               	movq	-0x28(%rbp), %r10
               	addq	%r11, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%rbx, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%r12, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%r14, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%rdx, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%rcx, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%rsi, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%rdi, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%r8, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%r9, %r10
               	movq	%r10, -0x28(%rbp)
               	movq	%r15, %r10
               	movq	-0x28(%rbp), %r15
               	addq	%r10, %r15
               	addq	-0x18(%rbp), %r15
               	addq	-0x20(%rbp), %r15
               	movq	-0x30(%rbp), %r10
               	cmpl	%r10d, %r13d
               	setl	%r13b
               	movzbq	%r13b, %r13
               	cmpl	%r11d, %r10d
               	setl	%r10b
               	movzbq	%r10b, %r10
               	addq	%r13, %r10
               	cmpl	%ebx, %r11d
               	setl	%r11b
               	movzbq	%r11b, %r11
               	addq	%r11, %r10
               	cmpl	%r12d, %ebx
               	setl	%r11b
               	movzbq	%r11b, %r11
               	addq	%r11, %r10
               	cmpl	%r14d, %r12d
               	setl	%r11b
               	movzbq	%r11b, %r11
               	addq	%r11, %r10
               	cmpl	%ecx, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	addq	%r10, %rdx
               	cmpl	%esi, %ecx
               	setg	%cl
               	movzbq	%cl, %rcx
               	addq	%rdx, %rcx
               	cmpl	%r8d, %edi
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %rcx
               	cmpl	%r9d, %r8d
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %rcx
               	cmpl	%edi, %r9d
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %rcx
               	addq	%r15, %rcx
               	movzbq	(%rax), %rdx
               	leaq	0xffff(%rax), %rsi
               	movzbq	(%rsi), %rsi
               	addq	%rdx, %rsi
               	movzbq	0x2(%rax), %rdx
               	movzbq	0x3(%rax), %rax
               	addq	%rax, %rdx
               	cmpl	$0xe0, %ecx
               	jne	<addr>
               	cmpl	$0x8, %esi
               	jne	<addr>
               	cmpl	$0x7, %edx
               	jne	<addr>
               	movl	$0x2a, %eax
               	leaq	-0x70(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
