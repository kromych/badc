
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
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rsi
               	cmpl	$0x1, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	(%rax), %rsi
               	cmpl	$0x2, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movslq	(%rax), %rsi
               	cmpl	$0x2, %esi
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movslq	(%rax), %rsi
               	leaq	-0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	subq	$0x2, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rdi)
               	movl	%ecx, (%rsi,%rax,4)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rsi)
               	movl	$0x2, (%rcx,%rax,4)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rsi)
               	movl	$0x3, (%rcx,%rax,4)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	$0x0, (%rdx,%rcx,4)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	$0x0, (%rdx,%rcx,4)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rsi)
               	movl	$0x4, (%rdx,%rcx,4)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x1b, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rsi)
               	movl	$0x1, (%rdx,%rcx,4)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	$0x0, (%rdx,%rcx,4)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	$0x0, (%rdx,%rcx,4)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	$0x0, (%rdx,%rcx,4)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1d, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	$0x6, (%rdx,%rcx,4)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rsi)
               	movl	$0x1, (%rdx,%rcx,4)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	$0x6, (%rdx,%rcx,4)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rdi)
               	movl	$0x3, (%rsi,%rcx,4)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rdi)
               	movl	$0x6, (%rsi,%rcx,4)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rdi)
               	movl	$0x3, (%rsi,%rcx,4)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rsi)
               	movl	$0x6, (%rdx,%rcx,4)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rdx)
               	movl	$0x6, (%rcx,%rax,4)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
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
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rdi)
               	movl	$0x1, (%rsi,%rcx,4)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rdi)
               	movl	$0x1, (%rsi,%rcx,4)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
