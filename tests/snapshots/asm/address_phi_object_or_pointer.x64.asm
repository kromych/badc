
address_phi_object_or_pointer.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<pick_mem>:
               	movslq	%esi, %rsi
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	shlq	$0x3, %rsi
               	leaq	(%rdi,%rsi), %rax
               	movq	(%rax), %rax
               	jmp	<addr>

<pick_ptr>:
               	testl	%esi, %esi
               	je	<addr>
               	leaq	0x1(%rdx), %rax
               	retq
               	movq	(%rdi), %rdx
               	jmp	<addr>

<pick_scalar>:
               	movq	%rdx, %rax
               	shlq	%rax
               	testl	%esi, %esi
               	je	<addr>
               	retq
               	movq	(%rdi), %rax
               	jmp	<addr>

<sum_some>:
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	%esi, %eax
               	jge	<addr>
               	imulq	$0xa, %rax, %rcx
               	movslq	%ecx, %rcx
               	nopl	(%rax,%rax)
               	testb	$0x1, %al
               	jne	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	jmp	<addr>
               	movq	%rdx, %rax
               	retq

<guarded>:
               	subq	$0x18, %rsp
               	movq	<rip>, %rax # <addr>
               	movq	%rax, 0x8(%rsp)
               	testl	%esi, %esi
               	jne	<addr>
               	leaq	0x8(%rsp), %rdi
               	movq	(%rdi), %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x48, %rsp
               	leaq	0x8(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x2, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	leaq	0x8(%rsp), %rdi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	0x8(%rsp), %rdi
               	movl	$0x1, %esi
               	movq	<rip>, %rdx # <addr>
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	leaq	0x8(%rsp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	movl	$0x1, %esi
               	movq	<rip>, %rdx # <addr>
               	callq	<addr>
               	cmpq	$0xc, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	xorl	%esi, %esi
               	movq	<rip>, %rdx # <addr>
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x2c, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
