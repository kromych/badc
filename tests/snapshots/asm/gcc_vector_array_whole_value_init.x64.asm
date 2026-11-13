
gcc_vector_array_whole_value_init.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm2
               	movups	%xmm0, -0x60(%rbp)
               	movups	%xmm1, -0x50(%rbp)
               	movups	%xmm2, -0x40(%rbp)
               	movups	%xmm0, -0x60(%rbp)
               	movups	%xmm1, -0x50(%rbp)
               	movups	%xmm2, -0x40(%rbp)
               	movups	%xmm0, -0x60(%rbp)
               	movups	%xmm1, -0x50(%rbp)
               	movups	%xmm2, -0x40(%rbp)
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm2, -0x60(%rbp)
               	movabsq	$0x707070707070707, %rax # imm = 0x707070707070707
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movups	%xmm1, -0x50(%rbp)
               	movzbq	-0x60(%rbp), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movzbq	-0x51(%rbp), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movabsq	$0x303030303030303, %rax # imm = 0x303030303030303
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movups	%xmm0, -0x50(%rbp)
               	movzbq	-0x59(%rbp), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm0, -0x40(%rbp)
               	movups	%xmm1, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movups	%xmm2, -0x60(%rbp)
               	leaq	0x10(%rax), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rax), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, -0x60(%rbp)
               	movups	%xmm1, -0x50(%rbp)
               	movups	%xmm2, -0x40(%rbp)
               	movups	%xmm0, -0x30(%rbp)
               	movups	%xmm0, -0x60(%rbp)
               	movups	%xmm1, -0x50(%rbp)
               	movups	%xmm2, -0x40(%rbp)
               	movups	%xmm2, -0x30(%rbp)
               	movups	%xmm1, -0x20(%rbp)
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm0, -0x60(%rbp)
               	movl	$0x5, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	movl	$0x6, -0x30(%rbp)
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xc, %eax
               	leave
               	retq
