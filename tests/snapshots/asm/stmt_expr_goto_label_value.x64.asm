
stmt_expr_goto_label_value.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x18, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%edx, %edx
               	movq	%rdx, %rdi
               	movq	%rdx, %r9
               	movq	%rdx, %r10
               	jmp	<addr>
               	incq	%rdi
               	cmpl	$0x64, %edx
               	jae	<addr>
               	cmpl	$0xc8, %edi
               	jae	<addr>
               	incq	%r9
               	addq	%rdx, %r10
               	leaq	0x1(%rdx), %r8
               	movl	$0x64, %edx
               	cmpl	$0x64, %r8d
               	jae	<addr>
               	movq	%r8, %rax
               	shrq	$0x6, %rax
               	movq	(%rsp,%rax,8), %rcx
               	movq	$-0x1, %r11
               	andq	$0x3f, %r8
               	shlxq	%r8, %r11, %r8
               	andq	%r8, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, %rcx
               	shlq	$0x6, %rcx
               	nop
               	cmpq	$0x64, %rcx
               	jae	<addr>
               	movq	(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	shlq	$0x6, %rax
               	movl	$0x40, %r8d
               	bsfq	%rcx, %rcx
               	cmovel	%r8d, %ecx
               	addq	%rcx, %rax
               	cmpq	$0x64, %rax
               	cmovbeq	%rax, %rdx
               	jmp	<addr>
               	cmpq	$0x5, %r9
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpq	$0xcb, %r10
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	incq	%rax
               	movq	%rax, %rcx
               	shlq	$0x6, %rcx
               	cmpq	$0x64, %rcx
               	jae	<addr>
               	movq	(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	shlq	$0x6, %rax
               	movl	$0x40, %r11d
               	bsfq	%rcx, %rcx
               	cmovel	%r11d, %ecx
               	addq	%rcx, %rax
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq
