
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
               	subq	$0x38, %rsp
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, (%rsp)
               	leaq	(%rsp), %rax
               	movq	(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	movq	%rax, 0x8(%rsp)
               	movabsq	$0xdeadbeefcafe, %rcx   # imm = 0xDEADBEEFCAFE
               	leaq	0x8(%rsp), %rdx
               	movq	%rcx, %r10
               	xchgq	%r10, (%rdx)
               	movq	0x8(%rsp), %rcx
               	movabsq	$0xdeadbeefcafe, %r11   # imm = 0xDEADBEEFCAFE
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x2a, 0x10(%rsp)
               	leaq	0x10(%rsp), %rcx
               	movl	(%rcx), %ecx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	%eax, 0x18(%rsp)
               	leaq	0x18(%rsp), %rcx
               	movl	$0xfffffff9, %edx       # imm = 0xFFFFFFF9
               	movl	%edx, (%rcx)
               	movl	0x18(%rsp), %ecx
               	cmpl	$-0x7, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	$0x1000, 0x20(%rsp)     # imm = 0x1000
               	leaq	0x20(%rsp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x1000, %rcx           # imm = 0x1000
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	addq	$0x38, %rsp
               	retq
