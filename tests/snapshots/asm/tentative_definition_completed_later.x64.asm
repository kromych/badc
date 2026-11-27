
tentative_definition_completed_later.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx # <addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x10, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x4, %eax
               	movq	%rax, <rip> # <addr>
               	movl	$0x5, %ecx
               	movq	%rcx, <rip> # <addr>
               	movl	$0x6, %edx
               	movq	%rdx, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x4, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x5, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x6, %rsi
               	je	<addr>
               	retq
               	movl	$0x7, %esi
               	movb	%sil, <rip> # <addr>
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	movsbq	<rip>, %rdi # <addr>
               	cmpl	$0x7, %edi
               	jne	<addr>
               	movl	$0x8, %edi
               	movq	%rdi, <rip> # <addr>
               	movl	%eax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movl	$0x9, %edx
               	movq	%rdx, <rip> # <addr>
               	movl	%eax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movq	%rsi, %rax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	$0xa, <rip> # <addr>
               	movl	$0xb, %ecx
               	movb	%cl, <rip> # <addr>
               	movb	%cl, <rip> # <addr>
               	testb	$0x1f, %sil
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0xa, %rsi
               	je	<addr>
               	movq	%rdi, %rax
               	retq
               	movabsq	$0x100000000, %rsi      # imm = 0x100000000
               	movq	%rsi, <rip> # <addr>
               	movl	%eax, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	$-0x1, <rip> # <addr>
               	movb	$0x2, <rip> # <addr>
               	movb	$0xc, <rip> # <addr>
               	movzbq	<rip>, %rdx # <addr>
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movl	$0xd, %ecx
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x8, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x9, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	retq
               	movq	%rcx, %rax
               	retq
               	movq	%rcx, %rax
               	retq
