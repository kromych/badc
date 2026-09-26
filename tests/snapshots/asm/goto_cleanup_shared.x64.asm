
goto_cleanup_shared.x64:	file format elf64-x86-64

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

<many>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	movl	$0x0, -0x8(%rbp)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movb	$0x61, (%rdx,%rsi)
               	movslq	(%rcx), %rdi
               	movb	$0x0, (%rdx,%rdi)
               	movslq	(%rcx), %rdi
               	leaq	0x1(%rdi), %r9
               	movl	%r9d, (%rcx)
               	movb	$0x7c, (%rdx,%rdi)
               	movslq	(%rcx), %rcx
               	movb	$0x0, (%rdx,%rcx)
               	leave
               	retq
               	cmpl	$0x2, %eax
               	je	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	leaq	-0x3(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	leaq	-0x4(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rcx)
               	movb	$0x2d, (%rax,%rdx)
               	movslq	(%rcx), %rsi
               	movb	$0x0, (%rax,%rsi)
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movb	$0x61, (%rax,%rsi)
               	movslq	(%rcx), %rcx
               	movb	$0x0, (%rax,%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movb	$0x2e, (%rax,%rsi)
               	movslq	(%rcx), %rcx
               	movb	$0x0, (%rax,%rcx)
               	xorl	%eax, %eax
               	leave
               	retq

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdi
               	leaq	0x1(%rdi), %r9
               	movl	%r9d, (%rdx)
               	movb	$0x61, (%rsi,%rdi)
               	movslq	(%rdx), %rdx
               	movb	%al, (%rsi,%rdx)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdi
               	leaq	0x1(%rdi), %r9
               	movl	%r9d, (%rdx)
               	movb	$0x7c, (%rsi,%rdi)
               	movslq	(%rdx), %rdx
               	movb	%al, (%rsi,%rdx)
               	leaq	0xa(%rcx), %rax
               	leave
               	retq
               	leaq	0x1(%rdi), %rcx
               	cmpl	$0x2, %edi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdi
               	leaq	0x1(%rdi), %r9
               	movl	%r9d, (%rdx)
               	movb	$0x61, (%rsi,%rdi)
               	movslq	(%rdx), %rdx
               	movb	%al, (%rsi,%rdx)
               	jmp	<addr>
               	cmpl	$0x3, %edi
               	je	<addr>
               	cmpl	$0x4, %edi
               	je	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rdi
               	leaq	0x1(%rdi), %r9
               	movl	%r9d, (%rsi)
               	movb	$0x2d, (%rdx,%rdi)
               	movslq	(%rsi), %rsi
               	movb	%al, (%rdx,%rsi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x61, (%rdx,%rsi)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rdx,%rax)
               	movq	%rcx, %rax
               	leave
               	retq

<lists>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x0, -0x8(%rbp)
               	cmpl	$0x1, %edi
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x61, (%rdx,%rsi)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rdx,%rax)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x7c, (%rcx,%rdx)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	cmpl	$0x2, %edi
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x62, (%rdx,%rsi)
               	movslq	(%rax), %rsi
               	movb	$0x0, (%rdx,%rsi)
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x61, (%rdx,%rcx)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rdx,%rax)
               	jmp	<addr>
               	cmpl	$0x3, %edi
               	je	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x2d, (%rdx,%rsi)
               	movslq	(%rax), %rsi
               	movb	$0x0, (%rdx,%rsi)
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x62, (%rdx,%rcx)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rdx,%rax)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x61, (%rdx,%rsi)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rdx,%rax)
               	jmp	<addr>

<vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x10, %r12d
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movq	%rax, %rdi
               	movq	%rax, %r8
               	movl	$0x0, -0x10(%rbp)
               	movq	%rsp, %rbx
               	movq	%r12, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r9
               	subq	%r11, %r9
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r9, %rsp
               	movb	%al, (%r9)
               	testq	%r8, %r8
               	jne	<addr>
               	movq	%r9, %r8
               	cmpl	$0x1, %esi
               	jne	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movslq	(%rcx), %r9
               	leaq	0x1(%r9), %r14
               	movl	%r14d, (%rcx)
               	movb	$0x61, (%rdx,%r9)
               	movslq	(%rcx), %r9
               	movb	$0x0, (%rdx,%r9)
               	movq	%rbx, %rsp
               	jmp	<addr>
               	cmpl	$0x1, %esi
               	je	<addr>
               	movslq	(%rcx), %r9
               	leaq	0x1(%r9), %r14
               	movl	%r14d, (%rcx)
               	movb	$0x2d, (%rdx,%r9)
               	movslq	(%rcx), %r9
               	movb	$0x0, (%rdx,%r9)
               	movslq	(%rcx), %r9
               	leaq	0x1(%r9), %r14
               	movl	%r14d, (%rcx)
               	movb	$0x61, (%rdx,%r9)
               	movslq	(%rcx), %r9
               	movb	$0x0, (%rdx,%r9)
               	movq	%rbx, %rsp
               	jmp	<addr>
               	cmpq	%r8, %r9
               	je	<addr>
               	movl	$0x1, %edi
               	jmp	<addr>
               	movslq	(%rcx), %r9
               	leaq	0x1(%r9), %r13
               	movl	%r13d, (%rcx)
               	movb	$0x2e, (%rdx,%r9)
               	movslq	(%rcx), %r9
               	movb	$0x0, (%rdx,%r9)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movb	$0x0, (%rcx)
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movb	$0x0, (%rcx)
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpl	$0x2, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movb	$0x0, (%rcx)
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x3, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movb	$0x0, (%rcx)
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x4, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movb	$0x0, (%rcx)
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rax
               	xorl	%edi, %edi
               	movl	%edi, (%rax)
               	movb	%dil, (%rcx)
               	callq	<addr>
               	cmpl	$0x1, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movb	$0x0, (%rcx)
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movb	$0x0, (%rcx)
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpl	$0xd, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movb	$0x0, (%rcx)
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xe, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movb	$0x0, (%rcx)
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0xf, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	xorl	%edi, %edi
               	movl	%edi, (%rax)
               	movb	%dil, (%rbx)
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	movl	$0x3, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movsbq	(%rdx,%rax), %rsi
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	movb	%sil, (%rdx)
               	movl	$0x10, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movb	$0x0, (%rcx)
               	movl	$0x10, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x0, (%rdx)
               	movb	$0x0, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	leave
               	retq
