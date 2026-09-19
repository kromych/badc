
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
               	movq	%rsi, %rax
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
               	movsbq	(%rcx,%rax), %rdx
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
               	movsbq	(%rcx,%rax), %rdx
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
               	movsbq	(%rcx,%rax), %rdx
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
               	movb	$0x3, (%rcx)
               	movb	$0x3, 0x1(%rcx)
               	movb	$0x3, 0x2(%rcx)
               	movb	$0x3, 0x3(%rcx)
               	movb	$0x3, 0x4(%rcx)
               	movb	$0x3, 0x5(%rcx)
               	movb	$0x3, 0x6(%rcx)
               	movb	$0x3, 0x7(%rcx)
               	movb	$0x3, 0x8(%rcx)
               	movb	$0x3, 0x9(%rcx)
               	movb	$0x3, 0xa(%rcx)
               	movb	$0x3, 0xb(%rcx)
               	xorl	%eax, %eax
               	cmpl	$0xc, %eax
               	jge	<addr>
               	movsbq	(%rcx,%rax), %rdx
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
               	movb	$0x5, 0x4(%rax)
               	movb	$0x5, 0x5(%rax)
               	movb	$0x5, 0x6(%rax)
               	movb	$0x5, 0x7(%rax)
               	movb	$0x5, 0x8(%rax)
               	movb	$0x5, 0x9(%rax)
               	movb	$0x5, 0xa(%rax)
               	movb	$0x5, 0xb(%rax)
               	movsbq	0x3(%rax), %rcx
               	cmpl	$0x7f, %ecx
               	jne	<addr>
               	leaq	0x4(%rax), %rcx
               	xorl	%eax, %eax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movsbq	(%rcx,%rax), %rdx
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
               	movl	$0xffffffff, (%rdi)     # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x4(%rdi)  # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x8(%rdi)  # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xc(%rdi)  # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x10(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x14(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x18(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x1c(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x20(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x24(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x28(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2c(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x30(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x34(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x38(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x3c(%rdi) # imm = 0xFFFFFFFF
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x10, %ebx
               	jge	<addr>
               	movslq	(%rcx,%rbx,4), %rdx
               	cmpl	$0xa, %ebx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	%eax, %edx
               	je	<addr>
               	jmp	<addr>
               	movq	$-0x1, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x10, %ebx
               	jl	<addr>
               	xorl	%edx, %edx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdx, %rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdi,%rax)
               	movb	%dl, (%rsi,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	$0x28, %edi
               	callq	<addr>
               	xorl	%edx, %edx
               	leaq	<rip>, %rsi
               	movq	%rdx, %rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movsbq	(%rsi,%rax), %rdi
               	cmpl	$0x28, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	cmpl	%ecx, %edi
               	je	<addr>
               	jmp	<addr>
               	movq	%rdx, %rcx
               	cmpl	%ecx, %edi
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
               	movsbq	(%rcx,%rax), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x9, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	cmpb	$0x0, 0x9(%rax)
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
