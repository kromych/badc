
atomic_generic.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xdeadbeefcafe, %rcx   # imm = 0xDEADBEEFCAFE
               	leaq	-0x28(%rbp), %rdx
               	movq	%rcx, %r10
               	xchgq	%r10, (%rdx)
               	movq	-0x28(%rbp), %rcx
               	movabsq	$0xdeadbeefcafe, %r11   # imm = 0xDEADBEEFCAFE
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x2a, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movl	(%rcx), %ecx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movl	$0xfffffff9, %edx       # imm = 0xFFFFFFF9
               	movl	%edx, (%rcx)
               	movl	-0x18(%rbp), %ecx
               	cmpl	$-0x7, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	$0x1000, -0x10(%rbp)    # imm = 0x1000
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x1000, %rcx           # imm = 0x1000
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leave
               	retq
