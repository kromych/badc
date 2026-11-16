
duff_switch_into_loop.x64:	file format elf64-x86-64

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

<send>:
               	movslq	%edx, %rdx
               	leaq	0x7(%rdx), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	sarq	$0x3, %rax
               	movq	%rdx, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rdx
               	andq	$0x7, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x8, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	incq	%rdi
               	incq	%rsi
               	movsbq	-0x1(%rsi), %rcx
               	movb	%cl, -0x1(%rdi)
               	incq	%rdi
               	incq	%rsi
               	movsbq	-0x1(%rsi), %rcx
               	movb	%cl, -0x1(%rdi)
               	incq	%rdi
               	incq	%rsi
               	movsbq	-0x1(%rsi), %rcx
               	movb	%cl, -0x1(%rdi)
               	incq	%rdi
               	incq	%rsi
               	movsbq	-0x1(%rsi), %rcx
               	movb	%cl, -0x1(%rdi)
               	incq	%rdi
               	incq	%rsi
               	movsbq	-0x1(%rsi), %rcx
               	movb	%cl, -0x1(%rdi)
               	incq	%rdi
               	incq	%rsi
               	movsbq	-0x1(%rsi), %rcx
               	movb	%cl, -0x1(%rdi)
               	incq	%rdi
               	incq	%rsi
               	movsbq	-0x1(%rsi), %rcx
               	movb	%cl, -0x1(%rdi)
               	incq	%rdi
               	incq	%rsi
               	movsbq	-0x1(%rsi), %rcx
               	movb	%cl, -0x1(%rdi)
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%al, -0x50(%rbp,%rax)
               	movb	%cl, -0x28(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x27, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rbx
               	leaq	-0x50(%rbp), %rsi
               	movl	$0x27, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	-0x28(%rbp,%rax), %rcx
               	movsbq	-0x50(%rbp,%rax), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x27, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
