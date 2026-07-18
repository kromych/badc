
atomic_generic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, -0x8(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x18(%rbp)
               	movabsq	$0xdeadbeefcafe, %rax   # imm = 0xDEADBEEFCAFE
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	movq	-0x18(%rbp), %rax
               	movabsq	$0xdeadbeefcafe, %r11   # imm = 0xDEADBEEFCAFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movl	%eax, -0x28(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x30(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movslq	-0x30(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x38(%rbp)
               	movabsq	$-0x7, %rax
               	movl	%eax, -0x40(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rax)
               	movslq	-0x38(%rbp), %rax
               	cmpq	$-0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1000, %eax           # imm = 0x1000
               	movq	%rax, -0x48(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x50(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	-0x50(%rbp), %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
