
anon_union_nested_init.x64:	file format elf64-x86-64

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

<opaque>:
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x38, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x3, 0x30(%rsp)
               	movl	$0x5, 0x38(%rsp)
               	movl	0x30(%rsp), %ebx
               	movl	0x38(%rsp), %r12d
               	leaq	0x20(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movb	%bl, 0x20(%rsp)
               	movb	%r12b, 0x21(%rsp)
               	leaq	(%rbx,%r12), %rax
               	movb	%al, 0x22(%rsp)
               	movq	%rbx, %rax
               	imulq	%r12, %rax
               	movb	%al, 0x23(%rsp)
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
               	addq	$0x38, %rsp
               	retq
               	movl	$0x6070809, 0x18(%rsp)  # imm = 0x6070809
               	movl	%ebx, 0x1c(%rsp)
               	leaq	0x18(%rsp), %rdi
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
