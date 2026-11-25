
string_memmem.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x3, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x4, %ecx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x1, %ecx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xb, %ecx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x3, %ecx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x8(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x2, %ecx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x3, %ecx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x1(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x1, %ecx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x2(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x2, %ecx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x7, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x5, %ecx
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x3, %ecx
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x2, %ecx
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x3, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x2, %ecx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x2, %ecx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x1, %ecx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x1, %ecx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx # <addr>
               	xorl	%ecx, %ecx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%r11
               	retq
               	xorl	%esi, %esi
               	leaq	<rip>, %rdx # <addr>
               	xorl	%ecx, %ecx
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
