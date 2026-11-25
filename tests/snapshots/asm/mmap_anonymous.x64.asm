
mmap_anonymous.x64:	file format elf64-x86-64

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
               	pushq	%rax
               	xorl	%edi, %edi
               	movl	$0x4000, %esi           # imm = 0x4000
               	movl	$0x3, %edx
               	movl	$0x22, %ecx
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$-0x1, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movb	$0x1, (%rdi)
               	leaq	0x1000(%rdi), %rax
               	movb	$0x2, (%rax)
               	leaq	0x2000(%rdi), %rax
               	movb	$0x3, (%rax)
               	leaq	0x3000(%rdi), %rax
               	movb	$0x4, (%rax)
               	movl	$0x4000, %esi           # imm = 0x4000
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
