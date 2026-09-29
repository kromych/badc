
tentative_definition_completed_later.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x10(%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	cmpq	$0x0, 0x10(%rcx)
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	cmpq	$0x0, (%rdx)
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	cmpq	$0x0, 0x8(%rdx)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	$0x1, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	leaq	<rip>, %rsi      # <addr>
               	movl	$0x0, (%rsi)
               	movq	0x8(%rax), %rsi
               	cmpq	$0x2, %rsi
               	jne	<addr>
               	movq	0x10(%rax), %rsi
               	cmpq	$0x3, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi      # <addr>
               	movq	(%rsi), %rsi
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rsi      # <addr>
               	movq	(%rsi), %rsi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi      # <addr>
               	movq	(%rsi), %rsi
               	addq	$0x10, %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rsi      # <addr>
               	movl	$0x4, %eax
               	movq	%rax, 0x10(%rsi)
               	movq	$0x5, (%rcx)
               	movl	$0x6, %edi
               	movq	%rdi, 0x10(%rcx)
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x0, (%rcx)
               	movq	0x10(%rsi), %rcx
               	cmpq	$0x4, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rdx
               	cmpq	$0x5, %rdx
               	jne	<addr>
               	movq	0x10(%rcx), %rcx
               	cmpq	$0x6, %rcx
               	je	<addr>
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movl	$0x7, %eax
               	movb	%al, 0x17(%rdx)
               	leaq	<rip>, %rsi      # <addr>
               	movl	$0x0, (%rsi)
               	movsbq	0x17(%rdx), %rdx
               	cmpl	$0x7, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movq	$0x8, 0x10(%rdx)
               	leaq	<rip>, %rsi      # <addr>
               	movl	$0x0, (%rsi)
               	movq	0x10(%rdx), %rdx
               	cmpq	$0x8, %rdx
               	je	<addr>
               	movq	%rdi, %rax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movl	$0x9, %esi
               	movq	%rsi, 0x10(%rdx)
               	leaq	<rip>, %rdi      # <addr>
               	movl	$0x0, (%rdi)
               	movq	0x10(%rdx), %rdx
               	cmpq	$0x9, %rdx
               	je	<addr>
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movq	$0xa, 0x8(%rdx)
               	leaq	<rip>, %rdi      # <addr>
               	leaq	<rip>, %r8       # <addr>
               	movl	$0xb, %eax
               	movb	%al, (%r8)
               	movb	%al, (%rdi)
               	testb	$0x1f, %dl
               	jne	<addr>
               	movq	0x8(%rdx), %rdx
               	cmpq	$0xa, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movabsq	$0x100000000, %rdi      # imm = 0x100000000
               	movq	%rdi, (%rdx)
               	leaq	<rip>, %rdi      # <addr>
               	movl	$0x0, (%rdi)
               	movq	(%rdx), %rcx
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rsi, %rax
               	retq
               	movq	$-0x1, (%rdx)
               	leaq	<rip>, %rcx      # <addr>
               	movb	$0x2, (%rcx)
               	leaq	<rip>, %rdx      # <addr>
               	movl	$0xc, %esi
               	movb	%sil, (%rdx)
               	movzbq	(%rcx), %rcx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movsbq	(%rdx), %rcx
               	cmpl	$0xc, %ecx
               	je	<addr>
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0xd, %eax
               	movq	%rax, 0x10(%rcx)
               	cmpq	$0xd, %rax
               	je	<addr>
               	movq	%rsi, %rax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	0x8(%rcx), %rdx
               	cmpq	$0x8, %rdx
               	jne	<addr>
               	movq	0x10(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0x5, %eax
               	retq
