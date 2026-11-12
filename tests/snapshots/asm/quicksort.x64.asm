
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
               	movl	(%rdi), %eax
               	movl	(%rsi), %ecx
               	movl	%ecx, (%rdi)
               	movl	%eax, (%rsi)
               	retq

<partition>:
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movl	(%rdi,%rdx,4), %r8d
               	leaq	-0x1(%rsi), %rax
               	cmpl	%edx, %esi
               	jge	<addr>
               	movl	(%rdi,%rsi,4), %ecx
               	cmpl	%r8d, %ecx
               	jg	<addr>
               	incq	%rax
               	movl	(%rdi,%rax,4), %r9d
               	movl	%ecx, (%rdi,%rax,4)
               	movl	%r9d, (%rdi,%rsi,4)
               	incq	%rsi
               	cmpl	%edx, %esi
               	jl	<addr>
               	incq	%rax
               	movslq	%eax, %rcx
               	movl	(%rdi,%rcx,4), %esi
               	movl	(%rdi,%rdx,4), %r8d
               	movl	%r8d, (%rdi,%rcx,4)
               	movl	%esi, (%rdi,%rdx,4)
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
               	movslq	%esi, %rcx
               	cmpl	%r12d, %ecx
               	jge	<addr>
               	movl	(%rbx,%r12,4), %edx
               	leaq	-0x1(%rcx), %rax
               	movq	%rcx, %rsi
               	cmpl	%r12d, %esi
               	jge	<addr>
               	movl	(%rbx,%rsi,4), %edi
               	cmpl	%edx, %edi
               	jg	<addr>
               	incq	%rax
               	movl	(%rbx,%rax,4), %edi
               	movl	(%rbx,%rsi,4), %r8d
               	movl	%r8d, (%rbx,%rax,4)
               	movl	%edi, (%rbx,%rsi,4)
               	incq	%rsi
               	cmpl	%r12d, %esi
               	jl	<addr>
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	movl	(%rbx,%rax,4), %edx
               	movl	(%rbx,%r12,4), %esi
               	movl	%esi, (%rbx,%rax,4)
               	movl	%edx, (%rbx,%r12,4)
               	leaq	-0x1(%r13), %rdx
               	movq	%rbx, %rdi
               	movq	%rcx, %rsi
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
               	movl	$0xc, (%rbx)
               	movl	$0x4, %edx
               	movl	$0x7, 0x4(%rbx)
               	movl	$0xf, 0x8(%rbx)
               	movl	$0x5, 0xc(%rbx)
               	movl	$0xa, 0x10(%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	(%rbx), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0x4(%rbx), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0x8(%rbx), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0xc(%rbx), %eax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0x10(%rbx), %eax
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
