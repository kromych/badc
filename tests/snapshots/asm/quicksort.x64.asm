
quicksort.x64:	file format elf64-x86-64

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

<swap>:
               	movslq	(%rdi), %rax
               	movslq	(%rsi), %rcx
               	movl	%ecx, (%rdi)
               	movl	%eax, (%rsi)
               	retq

<partition>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edx, %rbx
               	movslq	(%rdi,%rbx,4), %r8
               	leaq	-0x1(%rsi), %rax
               	cmpl	%ebx, %esi
               	jge	<addr>
               	movslq	%esi, %rcx
               	movslq	(%rdi,%rcx,4), %rdx
               	cmpl	%r8d, %edx
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rdx
               	movslq	(%rdi,%rdx,4), %r9
               	movslq	(%rdi,%rcx,4), %r12
               	movl	%r12d, (%rdi,%rdx,4)
               	movl	%r9d, (%rdi,%rcx,4)
               	incq	%rsi
               	cmpl	%ebx, %esi
               	jl	<addr>
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rcx
               	movslq	(%rdi,%rcx,4), %rsi
               	movslq	(%rdi,%rbx,4), %r8
               	movl	%r8d, (%rdi,%rcx,4)
               	movl	%esi, (%rdi,%rbx,4)
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<quicksort>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movslq	%edx, %r14
               	movslq	%esi, %r12
               	cmpl	%r14d, %r12d
               	jge	<addr>
               	movslq	%r14d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%r12), %rax
               	movq	%r12, %rsi
               	cmpl	%r9d, %esi
               	jge	<addr>
               	movslq	%esi, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	cmpl	%edi, %edx
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rdx
               	movslq	(%rbx,%rdx,4), %r8
               	movslq	(%rbx,%rcx,4), %r13
               	movl	%r13d, (%rbx,%rdx,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	incq	%rsi
               	cmpl	%r9d, %esi
               	jl	<addr>
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	leaq	-0x1(%r13), %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	0x1(%r13), %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x14, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%esi, %esi
               	movl	$0xc, %eax
               	movl	%eax, (%rbx)
               	movl	$0x4, %edx
               	movl	$0x7, %eax
               	movl	%eax, 0x4(%rbx)
               	movl	$0xf, %eax
               	movl	%eax, 0x8(%rbx)
               	movl	$0x5, %eax
               	movl	%eax, 0xc(%rbx)
               	movl	$0xa, %eax
               	movl	%eax, 0x10(%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	0x4(%rbx), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	0x8(%rbx), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	0xc(%rbx), %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	0x10(%rbx), %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
