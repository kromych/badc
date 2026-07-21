
quicksort.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	movslq	(%rdi,%rcx,4), %rdx
               	cmpq	%r8, %rdx
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
               	movslq	%esi, %rcx
               	cmpq	%rbx, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rdi,%rcx,4), %rdx
               	movslq	(%rdi,%rbx,4), %rsi
               	movl	%esi, (%rdi,%rcx,4)
               	movl	%edx, (%rdi,%rbx,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
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
               	cmpq	%r14, %r13
               	jge	<addr>
               	movslq	%r13d, %rdx
               	movslq	%r14d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
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
               	addq	$0x20, %rsp
               	popq	%rbp
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
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	0x4(%rbx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	0x8(%rbx), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%rbx), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	0x10(%rbx), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
