
flex_array_member_static_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	0xc(%rcx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rdx, %rdx
               	leaq	0x18(%rcx), %rax
               	leaq	(%rax), %rsi
               	movsbq	(%rsi), %rsi
               	cmpl	$-0x1, %esi
               	je	<addr>
               	leaq	0xa(%rdx), %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %edx
               	movsbq	0x1(%rax), %rsi
               	cmpl	$-0x1, %esi
               	je	<addr>
               	jmp	<addr>
               	movl	$0x2, %edx
               	movsbq	0x2(%rax), %rsi
               	cmpl	$-0x2, %esi
               	je	<addr>
               	jmp	<addr>
               	movl	$0x3, %edx
               	movsbq	0x3(%rax), %rsi
               	cmpl	$-0x2, %esi
               	je	<addr>
               	jmp	<addr>
               	movl	$0x4, %edx
               	movsbq	0x4(%rax), %rsi
               	cmpl	$0x5, %esi
               	je	<addr>
               	jmp	<addr>
               	movl	$0x5, %esi
               	movsbq	0x5(%rax), %rdi
               	cmpl	$0x6, %edi
               	je	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movl	$0x6, %edi
               	movsbq	0x6(%rax), %r8
               	cmpl	$0x7, %r8d
               	je	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movl	$0x7, %edi
               	movsbq	0x7(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rdi
               	addq	$0x4, %rdi
               	addq	$0x0, %rdi
               	movsbq	(%rdi), %rdi
               	cmpl	$0x68, %edi
               	je	<addr>
               	leaq	0x1e(%rcx), %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %ecx
               	leaq	<rip>, %rdi
               	addq	$0x4, %rdi
               	movsbq	0x1(%rdi), %rdi
               	cmpl	$0x65, %edi
               	je	<addr>
               	jmp	<addr>
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdi
               	addq	$0x4, %rdi
               	movsbq	0x2(%rdi), %rdi
               	cmpl	$0x6c, %edi
               	je	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	leaq	<rip>, %rdi
               	addq	$0x4, %rdi
               	movsbq	0x3(%rdi), %rdi
               	cmpl	$0x6c, %edi
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	movsbq	0x4(%rcx), %rcx
               	cmpl	$0x6f, %ecx
               	je	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	movsbq	0x5(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x12345678, %eax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x28, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x33, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x34, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	0x18(%rax), %rcx
               	movq	0x20(%rax), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x30(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x36, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x38(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	0x38(%rax), %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x37, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x40(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	0x40(%rax), %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x48(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x38, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x50(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	0x50(%rax), %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x39, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x58(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3a, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3c, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3d, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3e, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3f, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x30(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x40, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x38(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	0x38(%rax), %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x41, %eax
               	retq
               	xorq	%rax, %rax
               	retq
