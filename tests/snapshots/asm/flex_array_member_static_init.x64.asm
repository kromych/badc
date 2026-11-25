
flex_array_member_static_init.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	addq	$0xa, %rax
               	retq
               	movl	$0x1, %eax
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	movl	$0x2, %edx
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x3, %esi
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>
               	movl	$0x4, %edi
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movq	%rdi, %rax
               	jmp	<addr>
               	movl	$0x5, %ecx
               	movsbq	<rip>, %r8 # <addr>
               	cmpl	$0x6, %r8d
               	je	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x6, %ecx
               	movsbq	<rip>, %r8 # <addr>
               	cmpl	$0x7, %r8d
               	je	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x7, %ecx
               	movsbq	<rip>, %r8 # <addr>
               	cmpl	$0x8, %r8d
               	je	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	xorl	%ecx, %ecx
               	movsbq	<rip>, %r8 # <addr>
               	cmpl	$0x68, %r8d
               	je	<addr>
               	leaq	0x1e(%rcx), %rax
               	retq
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$0x65, %ecx
               	je	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x6c, %eax
               	je	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x6c, %eax
               	je	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x6f, %eax
               	je	<addr>
               	movq	%rdi, %rcx
               	jmp	<addr>
               	movl	$0x5, %ecx
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x12345678, %eax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x28, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	nopl	(%rax)
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x32, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x33, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x34, %eax
               	retq
               	addq	$0x18, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x35, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	nopl	(%rax,%rax)
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x36, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	nop
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x37, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x38, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x39, %eax
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x3a, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	nopl	(%rax)
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3c, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3d, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3e, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3f, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	nopl	(%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x40, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x41, %eax
               	retq
               	xorl	%eax, %eax
               	retq
