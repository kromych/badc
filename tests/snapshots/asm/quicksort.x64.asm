
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	movslq	%edx, %r9
               	movslq	(%rdi,%r9,4), %rdx
               	leaq	-0x1(%rsi), %rax
               	cmpl	%r9d, %esi
               	jge	<addr>
               	movslq	(%rdi,%rsi,4), %rcx
               	cmpl	%edx, %ecx
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	(%rdi,%rcx,4), %r8
               	movslq	(%rdi,%rsi,4), %rbx
               	movl	%ebx, (%rdi,%rcx,4)
               	movl	%r8d, (%rdi,%rsi,4)
               	incq	%rsi
               	cmpl	%r9d, %esi
               	jl	<addr>
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rcx
               	movslq	(%rdi,%rcx,4), %rsi
               	movslq	(%rdi,%r9,4), %r8
               	movl	%r8d, (%rdi,%rcx,4)
               	movl	%esi, (%rdi,%r9,4)
               	movq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<quicksort>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movslq	%edx, %r12
               	movslq	%esi, %r8
               	cmpl	%r12d, %r8d
               	jge	<addr>
               	movslq	(%rbx,%r12,4), %rdx
               	leaq	-0x1(%r8), %rax
               	movq	%r8, %rsi
               	cmpl	%r12d, %esi
               	jge	<addr>
               	movslq	(%rbx,%rsi,4), %rcx
               	cmpl	%edx, %ecx
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	(%rbx,%rcx,4), %rdi
               	movslq	(%rbx,%rsi,4), %r9
               	movl	%r9d, (%rbx,%rcx,4)
               	movl	%edi, (%rbx,%rsi,4)
               	incq	%rsi
               	cmpl	%r12d, %esi
               	jl	<addr>
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r12,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r12,4)
               	leaq	-0x1(%r13), %rdx
               	movq	%rbx, %rdi
               	movq	%r8, %rsi
               	callq	<addr>
               	leaq	0x1(%r13), %rsi
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	callq	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
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
