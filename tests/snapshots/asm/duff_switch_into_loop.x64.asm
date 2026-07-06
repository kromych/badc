
duff_switch_into_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<send>:
               	movq	%rsi, %r8
               	movslq	%edx, %rdx
               	leaq	0x7(%rdx), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rsi
               	sarq	$0x3, %rsi
               	movq	%rdx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3d, %rax
               	leaq	(%rdx,%rax), %rcx
               	andq	$0x7, %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x8, %rax
               	jae	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	movq	%rdi, %rcx
               	movq	%r8, %rdx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	leaq	0x1(%r8), %rcx
               	movsbq	(%r8), %rdx
               	movb	%dl, (%rdi)
               	movq	%rax, %rdi
               	movq	%rcx, %r8
               	leaq	0x1(%rdi), %rax
               	leaq	0x1(%r8), %rcx
               	movsbq	(%r8), %rdx
               	movb	%dl, (%rdi)
               	movq	%rax, %rdi
               	movq	%rcx, %r8
               	leaq	0x1(%rdi), %rax
               	leaq	0x1(%r8), %rcx
               	movsbq	(%r8), %rdx
               	movb	%dl, (%rdi)
               	movq	%rax, %rdi
               	movq	%rcx, %r8
               	leaq	0x1(%rdi), %rax
               	leaq	0x1(%r8), %rcx
               	movsbq	(%r8), %rdx
               	movb	%dl, (%rdi)
               	movq	%rax, %rdi
               	movq	%rcx, %r8
               	leaq	0x1(%rdi), %rax
               	leaq	0x1(%r8), %rcx
               	movsbq	(%r8), %rdx
               	movb	%dl, (%rdi)
               	movq	%rax, %rdi
               	movq	%rcx, %r8
               	leaq	0x1(%rdi), %rax
               	leaq	0x1(%r8), %rcx
               	movsbq	(%r8), %rdx
               	movb	%dl, (%rdi)
               	movq	%rax, %rdi
               	movq	%rcx, %r8
               	leaq	0x1(%rdi), %rcx
               	leaq	0x1(%r8), %rdx
               	movsbq	(%r8), %rax
               	movb	%al, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %r11         # <addr>
               	movslq	(%r11,%rax,4), %r10
               	addq	%r11, %r10
               	jmpq	*%r10
               	pushq	%rbp
               	<unknown>
               	decl	(%rsi)
               	addb	%al, (%rax)
               	pushq	%rax
               	addb	%al, (%rax)
               	addb	%dl, (%rbp)
               	addb	%al, (%rax)
               	popq	%rdx
               	addb	%al, (%rax)
               	addb	%bl, (%rdi)
               	addb	%al, (%rax)
               	addb	%al, %fs:(%rax)
               	addb	%ch, (%rcx)
               	addb	%al, (%rax)
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdi
               	leaq	0x1(%rdx), %r8
               	movsbq	(%rdx), %rax
               	movb	%al, (%rcx)
               	jmp	<addr>
               	decq	%rsi
               	movslq	%esi, %rax
               	testq	%rax, %rax
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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rdx
               	movslq	%ecx, %rsi
               	addq	%rax, %rdx
               	movb	%sil, (%rdx)
               	leaq	-0x50(%rbp), %rdx
               	addq	%rax, %rdx
               	xorq	%rsi, %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x27, %rax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x27, %edx
               	callq	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdx
               	addq	%rax, %rdx
               	movsbq	(%rdx), %rdx
               	leaq	-0x28(%rbp), %rsi
               	addq	%rax, %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x27, %rax
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
