
binary_operator_order.x64:	file format elf64-x86-64

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
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	leaq	<rip>, %rdx
               	movl	%ecx, (%rdx)
               	movl	$0x1, %eax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, (%rcx)
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	leaq	-0x1(%rdx), %rsi
               	movl	%esi, (%rcx)
               	leaq	-0x2(%rdx), %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorq	%rsi, %rsi
               	movl	%esi, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rdi)
               	movl	%eax, (%rdx,%rcx,4)
               	movl	$0x2, %r8d
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rcx
               	leaq	0x1(%rcx), %r9
               	movl	%r9d, (%rdi)
               	movl	%r8d, (%rdx,%rcx,4)
               	movq	%rax, %rcx
               	movl	$0x3, %r8d
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rcx
               	leaq	0x1(%rcx), %r9
               	movl	%r9d, (%rdi)
               	movl	%r8d, (%rdx,%rcx,4)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	movl	$0x1, %edx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	%esi, (%rax)
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rdi)
               	movl	%ecx, (%rsi,%rax,4)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rdi)
               	movl	%ecx, (%rsi,%rax,4)
               	movl	$0x4, %edi
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rsi)
               	movl	%edi, (%rcx,%rax,4)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	movl	$0x1, %edi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rsi)
               	movl	%edi, (%rdx,%rcx,4)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	%eax, (%rdx,%rcx,4)
               	movq	%rax, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	%eax, (%rdx,%rcx,4)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	%eax, (%rdx,%rcx,4)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	retq
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x6, %eax
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	%eax, (%rdx,%rcx,4)
               	movl	$0x1, %edi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rsi)
               	movl	%edi, (%rdx,%rcx,4)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	%eax, (%rdx,%rcx,4)
               	movl	$0x3, %edx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rdi)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rdi)
               	movl	%eax, (%rsi,%rcx,4)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rdi)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x6, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	%eax, (%rdx,%rcx,4)
               	movl	$0x6, %esi
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rdx)
               	movl	%esi, (%rcx,%rax,4)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	%eax, (%rdx,%rcx,4)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	%eax, (%rdx,%rcx,4)
               	movl	$0x1, %ecx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rdi)
               	movl	%ecx, (%rsi,%rdx,4)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rdi)
               	movl	%ecx, (%rsi,%rdx,4)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
