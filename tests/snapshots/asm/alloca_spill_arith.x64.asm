
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
               	movzbq	<rip>, %r13 # <addr>
               	movb	%r13b, (%rax)
               	movzbq	<rip>, %rdx # <addr>
               	movb	%dl, 0x1(%rax)
               	movzbq	<rip>, %rsi # <addr>
               	movb	%sil, 0x2(%rax)
               	movzbq	<rip>, %rdi # <addr>
               	movb	%dil, 0x3(%rax)
               	movzbq	<rip>, %r8 # <addr>
               	movb	%r8b, 0x4(%rax)
               	movzbq	<rip>, %r14 # <addr>
               	movb	%r14b, 0x5(%rax)
               	leaq	0xffff(%rax), %rcx
               	movzbq	<rip>, %r9 # <addr>
               	movb	%r9b, (%rcx)
               	leaq	(%r13,%rdx), %r9
               	leaq	(%rsi,%rdi), %rcx
               	leaq	(%r8,%r14), %r10
               	leaq	(%r9,%r9,2), %r11
               	leaq	(%rcx,%rcx,4), %rbx
               	imulq	$0x7, %r10, %r12
               	cmpl	%ecx, %r9d
               	movq	%rbx, %r15
               	cmovlq	%r11, %r15
               	movq	%r11, -0x30(%rbp)
               	cmpl	%r10d, %ecx
               	movq	%r12, %r11
               	cmovlq	%rbx, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x30(%rbp), %r11
               	movq	%r11, -0x30(%rbp)
               	cmpl	%r9d, %r10d
               	movq	-0x30(%rbp), %r11
               	movq	%r10, -0x30(%rbp)
               	movq	%r11, %r10
               	cmovlq	%r12, %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x30(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	leaq	(%r13,%rdx), %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%rsi, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%rdi, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%r8, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%r14, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%r9, %r10
               	movq	%r10, -0x28(%rbp)
               	addq	%rcx, %r10
               	movq	%r10, -0x28(%rbp)
               	movq	-0x30(%rbp), %r10
               	movq	%r11, -0x30(%rbp)
               	movq	-0x28(%rbp), %r11
               	addq	%r10, %r11
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
               	movq	%r15, %r10
               	movq	-0x28(%rbp), %r15
               	addq	%r10, %r15
               	addq	-0x18(%rbp), %r15
               	addq	-0x20(%rbp), %r15
               	cmpl	%edx, %r13d
               	setl	%r13b
               	movzbq	%r13b, %r13
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	addq	%r13, %rdx
               	cmpl	%edi, %esi
               	setl	%sil
               	movzbq	%sil, %rsi
               	addq	%rsi, %rdx
               	cmpl	%r8d, %edi
               	setl	%sil
               	movzbq	%sil, %rsi
               	addq	%rsi, %rdx
               	cmpl	%r14d, %r8d
               	setl	%sil
               	movzbq	%sil, %rsi
               	addq	%rsi, %rdx
               	cmpl	%ecx, %r9d
               	setg	%sil
               	movzbq	%sil, %rsi
               	addq	%rsi, %rdx
               	movq	-0x30(%rbp), %r10
               	cmpl	%r10d, %ecx
               	setg	%cl
               	movzbq	%cl, %rcx
               	addq	%rdx, %rcx
               	cmpl	%ebx, %r11d
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %rcx
               	cmpl	%r12d, %ebx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %rcx
               	cmpl	%r11d, %r12d
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
