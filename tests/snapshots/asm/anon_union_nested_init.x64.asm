
anon_union_nested_init.x64:	file format elf64-x86-64

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

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x3, -0x10(%rbp)
               	movl	$0x5, -0x8(%rbp)
               	movl	-0x10(%rbp), %ebx
               	movl	-0x8(%rbp), %r12d
               	leaq	-0x20(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movb	%bl, -0x20(%rbp)
               	movb	%r12b, -0x1f(%rbp)
               	leaq	(%rbx,%r12), %rax
               	movb	%al, -0x1e(%rbp)
               	movq	%rbx, %rax
               	imulq	%r12, %rax
               	movb	%al, -0x1d(%rbp)
               	callq	<addr>
               	movzbq	(%rax), %rcx
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rax
               	imulq	%rbx, %r12
               	andq	$0xff, %r12
               	cmpl	%r12d, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	movb	$0x9, -0x28(%rbp)
               	movb	$0x8, -0x27(%rbp)
               	movb	$0x7, -0x26(%rbp)
               	movb	$0x6, -0x25(%rbp)
               	movl	%ebx, -0x24(%rbp)
               	callq	<addr>
               	movzbq	(%rax), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	%ebx, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
