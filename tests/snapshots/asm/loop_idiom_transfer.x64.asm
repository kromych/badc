
loop_idiom_transfer.x64:	file format elf64-x86-64

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

<fill_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movl	$0x2, %eax
               	testl	%esi, %esi
               	jle	<addr>
               	leaq	(%rsi), %rdx
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<fill_words>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%esi, %esi
               	movl	$0x28, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<copy_arrays>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x28, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<fill_and_report>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movslq	%esi, %rbx
               	xorl	%esi, %esi
               	testl	%ebx, %ebx
               	jle	<addr>
               	movl	$0x1, %esi
               	leaq	(%rbx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rsi
               	movslq	%esi, %rax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x10, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	movsbq	(%rcx,%rdx), %rdx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	movsbq	0x10(%rax), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	movsbq	(%rcx,%rdx), %rdx
               	cmpl	$0x7f, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	$-0x3, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	movsbq	(%rcx,%rdx), %rdx
               	cmpl	$0x7f, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movl	$0x3, %eax
               	movb	%al, (%rcx)
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	xorl	%eax, %eax
               	cmpl	$0xc, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	movsbq	(%rcx,%rdx), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	movsbq	0xc(%rax), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	movb	%cl, 0x5(%rax)
               	movb	%cl, 0x6(%rax)
               	movb	%cl, 0x7(%rax)
               	movb	%cl, 0x8(%rax)
               	movb	%cl, 0x9(%rax)
               	movb	%cl, 0xa(%rax)
               	movb	%cl, 0xb(%rax)
               	movsbq	0x3(%rax), %rcx
               	cmpl	$0x7f, %ecx
               	jne	<addr>
               	leaq	0x4(%rax), %rcx
               	xorl	%eax, %eax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	movsbq	(%rcx,%rdx), %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	movsbq	0xc(%rax), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rdi
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, (%rdi)
               	movl	%eax, 0x4(%rdi)
               	movl	%eax, 0x8(%rdi)
               	movl	%eax, 0xc(%rdi)
               	movl	%eax, 0x10(%rdi)
               	movl	%eax, 0x14(%rdi)
               	movl	%eax, 0x18(%rdi)
               	movl	%eax, 0x1c(%rdi)
               	movl	%eax, 0x20(%rdi)
               	movl	%eax, 0x24(%rdi)
               	movl	%eax, 0x28(%rdi)
               	movl	%eax, 0x2c(%rdi)
               	movl	%eax, 0x30(%rdi)
               	movl	%eax, 0x34(%rdi)
               	movl	%eax, 0x38(%rdi)
               	movl	%eax, 0x3c(%rdi)
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x10, %ebx
               	jge	<addr>
               	movslq	%ebx, %rax
               	movslq	(%rcx,%rax,4), %rdx
               	cmpl	$0xa, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpq	%rax, %rdx
               	je	<addr>
               	jmp	<addr>
               	movq	$-0x1, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x10, %ebx
               	jl	<addr>
               	xorl	%esi, %esi
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	movq	%rsi, %rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	leaq	0x1(%rcx), %rdx
               	movq	%rdx, %r9
               	movb	%r9b, (%r8,%rcx)
               	movb	%sil, (%rdi,%rcx)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	$0x28, %edi
               	callq	<addr>
               	xorl	%edx, %edx
               	leaq	<rip>, %rsi
               	movq	%rdx, %rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	movsbq	(%rsi,%rcx), %rdi
               	cmpl	$0x28, %ecx
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	movq	%rcx, %r8
               	movsbq	%r8b, %rcx
               	cmpq	%rcx, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	%rdx, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x9, %esi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	cmpl	$0x9, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	movsbq	(%rcx,%rdx), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x9, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	movsbq	0x9(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movq	$-0x1, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
