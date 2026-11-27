
alloca_call_args.x64:	file format elf64-x86-64

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

<sum10>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x100000, %eax         # imm = 0x100000
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	xorl	%eax, %eax
               	movb	$0x7, (%rcx,%rax)
               	addq	$0x1000, %rax           # imm = 0x1000
               	cmpl	$0x100000, %eax         # imm = 0x100000
               	jl	<addr>
               	leaq	0xfffff(%rcx), %rdx
               	movl	$0x8, %eax
               	movb	%al, (%rdx)
               	movsbq	(%rcx), %rcx
               	leaq	0x8(%rcx), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, -0x20(%rbp)
               	subq	$0x20, %rsp
               	movq	$0x7, (%rsp)
               	movq	%rax, 0x8(%rsp)
               	movq	$0x9, 0x10(%rsp)
               	movq	$0xa, 0x18(%rsp)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movq	-0x20(%rbp), %r10
               	callq	*%r10
               	addq	$0x20, %rsp
               	movq	-0x18(%rbp), %rcx
               	cmpl	$0xf, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpq	$0x37, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
