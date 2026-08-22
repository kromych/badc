
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
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	sarq	$0x3, %rax
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rdx
               	andq	$0x7, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	cmpq	$0x8, %rcx
               	jae	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	movq	%rdi, %rcx
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rcx
               	leaq	0x1(%rsi), %rdx
               	movsbq	(%rsi), %rsi
               	movb	%sil, (%rdi)
               	movq	%rcx, %rdi
               	movq	%rdx, %rsi
               	leaq	0x1(%rdi), %rcx
               	leaq	0x1(%rsi), %rdx
               	movsbq	(%rsi), %rsi
               	movb	%sil, (%rdi)
               	movq	%rcx, %rdi
               	movq	%rdx, %rsi
               	leaq	0x1(%rdi), %rcx
               	leaq	0x1(%rsi), %rdx
               	movsbq	(%rsi), %rsi
               	movb	%sil, (%rdi)
               	movq	%rcx, %rdi
               	movq	%rdx, %rsi
               	leaq	0x1(%rdi), %rcx
               	leaq	0x1(%rsi), %rdx
               	movsbq	(%rsi), %rsi
               	movb	%sil, (%rdi)
               	movq	%rcx, %rdi
               	movq	%rdx, %rsi
               	leaq	0x1(%rdi), %rcx
               	leaq	0x1(%rsi), %rdx
               	movsbq	(%rsi), %rsi
               	movb	%sil, (%rdi)
               	movq	%rcx, %rdi
               	movq	%rdx, %rsi
               	leaq	0x1(%rdi), %rcx
               	leaq	0x1(%rsi), %rdx
               	movsbq	(%rsi), %rsi
               	movb	%sil, (%rdi)
               	movq	%rcx, %rdi
               	movq	%rdx, %rsi
               	leaq	0x1(%rdi), %rcx
               	leaq	0x1(%rsi), %rdx
               	movsbq	(%rsi), %rsi
               	movb	%sil, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	leaq	0x1(%rcx), %rdi
               	leaq	0x1(%rdx), %rsi
               	movsbq	(%rdx), %rdx
               	movb	%dl, (%rcx)
               	jmp	<addr>
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rsi
               	movslq	%eax, %rcx
               	addq	%rcx, %rsi
               	movb	%cl, (%rsi)
               	leaq	-0x28(%rbp), %rsi
               	addq	%rcx, %rsi
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x27, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rbx
               	leaq	-0x50(%rbp), %rsi
               	movl	$0x27, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rbx,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	-0x50(%rbp), %rsi
               	addq	%rcx, %rsi
               	movsbq	(%rsi), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x27, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
