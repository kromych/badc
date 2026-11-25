
duff_switch_into_loop.x64:	file format elf64-x86-64

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

<send>:
               	movslq	%edx, %rdx
               	leaq	0x7(%rdx), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	sarq	$0x3, %rax
               	movq	%rdx, %r8
               	shrq	$0x3d, %r8
               	leaq	(%rdx,%r8), %rcx
               	andq	$0x7, %rcx
               	subq	%r8, %rcx
               	cmpq	$0x8, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
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
               	nopl	(%rax)
               	testl	%eax, %eax
               	jg	<addr>
               	xorl	%eax, %eax
               	retq

<main>:
               	subq	$0x60, %rsp
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%al, 0x10(%rsp,%rax)
               	movb	%cl, 0x38(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x27, %eax
               	jl	<addr>
               	leaq	0x38(%rsp), %rbx
               	movq	%rbx, %rdi
               	leaq	0x10(%rsp), %rsi
               	movl	$0x27, %edx
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	0x38(%rsp,%rax), %rcx
               	movsbq	0x10(%rsp,%rax), %rdx
               	nop
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x27, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq
