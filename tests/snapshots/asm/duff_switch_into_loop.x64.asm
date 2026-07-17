
duff_switch_into_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	leaq	<rip>, %r11         # <addr>
               	movslq	(%r11,%rcx,4), %r10
               	addq	%r11, %r10
               	jmpq	*%r10
               	pushq	%rbp
               	<unknown>
               	decl	(%rcx)
               	addb	%al, (%rax)
               	addb	%al, (%r8)
               	addb	%dl, (%rax)
               	addb	%al, (%rax)
               	pushq	%rbp
               	addb	%al, (%rax)
               	addb	%bl, (%rdx)
               	addb	%al, (%rax)
               	popq	%rdi
               	addb	%al, (%rax)
               	addb	%ah, (%rax,%rax)
               	addb	%cl, -0x73(%rax)
               	jns	<addr>
               	leaq	0x1(%rdx), %rsi
               	movsbq	(%rdx), %rdx
               	movb	%dl, (%rcx)
               	jmp	<addr>
               	decq	%rax
               	movslq	%eax, %rsi
               	testq	%rsi, %rsi
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
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rsi
               	movslq	%eax, %rdx
               	addq	%rcx, %rsi
               	movb	%dl, (%rsi)
               	leaq	-0x50(%rbp), %rdx
               	addq	%rcx, %rdx
               	xorq	%rsi, %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x27, %rcx
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x27, %edx
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rdx
               	leaq	-0x28(%rbp), %rsi
               	addq	%rcx, %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x27, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
