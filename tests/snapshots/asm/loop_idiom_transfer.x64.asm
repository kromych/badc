
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
               	movq	%rsi, %rdx
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
               	movl	$0x28, %edx
               	leaq	<rip>, %rdi      # <addr>
               	leaq	<rip>, %rsi      # <addr>
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
               	movq	%rbx, %rdx
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
               	movsbq	(%rcx,%rax), %rdx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsbq	-0x30(%rbp), %rax
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
               	movb	$0x3, -0x40(%rbp)
               	movb	$0x3, -0x3f(%rbp)
               	movb	$0x3, -0x3e(%rbp)
               	movb	$0x3, -0x3d(%rbp)
               	movb	$0x3, -0x3c(%rbp)
               	movb	$0x3, -0x3b(%rbp)
               	movb	$0x3, -0x3a(%rbp)
               	movb	$0x3, -0x39(%rbp)
               	movb	$0x3, -0x38(%rbp)
               	movb	$0x3, -0x37(%rbp)
               	movb	$0x3, -0x36(%rbp)
               	movb	$0x3, -0x35(%rbp)
               	xorl	%eax, %eax
               	movsbq	(%rcx,%rax), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	movsbq	-0x34(%rbp), %rax
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
               	leaq	-0x40(%rbp), %rcx
               	movb	$0x5, -0x3c(%rbp)
               	movb	$0x5, -0x3b(%rbp)
               	movb	$0x5, -0x3a(%rbp)
               	movb	$0x5, -0x39(%rbp)
               	movb	$0x5, -0x38(%rbp)
               	movb	$0x5, -0x37(%rbp)
               	movb	$0x5, -0x36(%rbp)
               	movb	$0x5, -0x35(%rbp)
               	movsbq	-0x3d(%rbp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	addq	$0x4, %rcx
               	xorl	%eax, %eax
               	movsbq	(%rcx,%rax), %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movsbq	-0x34(%rbp), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rbx      # <addr>
               	movl	$0xffffffff, (%rbx)     # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x4(%rbx)  # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x8(%rbx)  # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xc(%rbx)  # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x10(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x14(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x18(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x1c(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x20(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x24(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x28(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2c(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x30(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x34(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x38(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x3c(%rbx) # imm = 0xFFFFFFFF
               	movl	$0xa, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movl	(%rbx,%rax,4), %esi
               	cmpl	$0xa, %eax
               	jge	<addr>
               	movq	%rcx, %rdx
               	cmpl	%edx, %esi
               	je	<addr>
               	jmp	<addr>
               	movq	$-0x1, %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rsi      # <addr>
               	leaq	<rip>, %rdi      # <addr>
               	movq	%rcx, %rax
               	leaq	0x1(%rax), %rdx
               	movb	%dl, (%rdi,%rax)
               	movb	%cl, (%rsi,%rax)
               	movq	%rdx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	$0x28, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rsi      # <addr>
               	movq	%rcx, %rax
               	movsbq	(%rsi,%rax), %rdi
               	cmpl	$0x28, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rdx
               	cmpl	%edx, %edi
               	je	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	cmpl	%edx, %edi
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
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	movsbq	(%rcx,%rax), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x9, %eax
               	jl	<addr>
               	cmpb	$0x0, -0x37(%rbp)
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movq	$-0x1, %rsi
               	callq	<addr>
               	testl	%eax, %eax
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
