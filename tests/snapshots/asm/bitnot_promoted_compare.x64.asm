
bitnot_promoted_compare.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movb	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movl	(%rax), %edx
               	movb	$0x0, -0x8(%rbp)
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rdx, %rcx
               	cmpl	%r11d, %edx
               	jae	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	(%rax), %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %ecx
               	jb	<addr>
               	movl	(%rax), %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %ecx
               	jb	<addr>
               	movl	(%rax), %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %ecx
               	jae	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movl	(%rsi), %ecx
               	movl	(%rax), %eax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jae	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	(%rcx), %r8d
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	(%rsi), %esi
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rax
               	xorq	$0x3, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	(%rcx), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movb	%al, (%rdx)
               	movl	(%rcx), %edx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %edx
               	jae	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movzbq	-0x8(%rbp), %rdx
               	xorq	$-0x1, %rdx
               	shlq	%rdx
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpl	%r11d, %edx
               	jne	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	xorq	$-0x1, %rdx
               	movl	%edx, %edx
               	shrq	%rdx
               	cmpl	$0x7fffffff, %edx       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movzbq	-0x8(%rbp), %rdx
               	xorq	$-0x1, %rdx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %edx
               	ja	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	xorq	$-0x1, %rcx
               	sarq	%rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movb	$0xf, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	movl	$0xfffffff0, %r11d      # imm = 0xFFFFFFF0
               	cmpl	%r11d, %ecx
               	jae	<addr>
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	movl	$0xfffffff0, %r11d      # imm = 0xFFFFFFF0
               	cmpl	%r11d, %ecx
               	jb	<addr>
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
