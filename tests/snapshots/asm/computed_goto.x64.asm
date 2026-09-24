
computed_goto.x64:	file format elf64-x86-64

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

<direct>:
               	testl	%edi, %edi
               	jne	<addr>
               	leaq	<rip>, %rax         # <addr>
               	jmpq	*%rax
               	movl	$0xa, %eax
               	retq
               	movl	$0x14, %eax
               	retq
               	leaq	-<rip>, %rax        # <addr>
               	jmpq	*%rax

<interp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rdx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, (%rdx)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x8(%rdx)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x10(%rdx)
               	movl	$0x1, %ecx
               	movslq	(%rdi), %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	jmpq	*%rdx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movslq	(%rdi,%rcx,4), %rcx
               	addq	%rcx, %rax
               	leaq	-0x18(%rbp), %rsi
               	movslq	%edx, %rdx
               	leaq	0x1(%rdx), %rcx
               	movslq	(%rdi,%rdx,4), %rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmpq	*%rdx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movslq	(%rdi,%rcx,4), %rcx
               	subq	%rcx, %rax
               	leaq	-0x18(%rbp), %rsi
               	movslq	%edx, %rdx
               	leaq	0x1(%rdx), %rcx
               	movslq	(%rdi,%rdx,4), %rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmpq	*%rdx
               	leave
               	retq

<loop_to>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rsi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, (%rsi)
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, 0x8(%rsi)
               	movq	%rcx, %rax
               	incq	%rax
               	cmpl	%edi, %eax
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmpq	*%rdx
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	movl	$0x1, %edx
               	jmp	<addr>
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	movl	0x18(%rax), %r10d
               	movl	%r10d, 0x18(%rdi)
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
