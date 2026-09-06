
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
               	xorq	%rax, %rax
               	retq

<partition>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdx, %rbx
               	movslq	%esi, %rsi
               	movslq	%ebx, %rbx
               	movslq	(%rdi,%rbx,4), %r8
               	leaq	-0x1(%rsi), %rax
               	jmp	<addr>
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
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rsi
               	cmpl	%ebx, %esi
               	jl	<addr>
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rcx
               	movslq	(%rdi,%rcx,4), %rsi
               	movslq	(%rdi,%rbx,4), %r8
               	movl	%r8d, (%rdi,%rcx,4)
               	movl	%esi, (%rdi,%rbx,4)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	leave
               	retq

<quicksort>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rdx, %r14
               	movq	%rsi, %r13
               	movslq	%r13d, %r13
               	movslq	%r14d, %r14
               	cmpl	%r14d, %r13d
               	jge	<addr>
               	movslq	%r13d, %rcx
               	movslq	%r14d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rcx), %rax
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	movslq	(%rbx,%rdx,4), %rsi
               	cmpl	%edi, %esi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rdx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rdx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %r12
               	movslq	(%rbx,%r12,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%r12,4)
               	movl	%edx, (%rbx,%r9,4)
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x14, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorq	%rsi, %rsi
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
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	0x4(%rbx), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	0x8(%rbx), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	0xc(%rbx), %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	0x10(%rbx), %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
