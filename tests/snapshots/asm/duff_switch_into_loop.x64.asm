
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
               	addb	%ch, %cl
               	xorb	%bh, %bh
               	<unknown>
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x27, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	movb	%dl, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	xorq	%rdx, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x27, %edx
               	callq	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x27, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	movsbq	(%rax), %rax
               	leaq	-0x28(%rbp), %rdx
               	movslq	%ecx, %rsi
               	addq	%rsi, %rdx
               	movsbq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
