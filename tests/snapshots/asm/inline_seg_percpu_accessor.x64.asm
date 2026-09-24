
inline_seg_percpu_accessor.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movq	%rcx, 0x8(%rax)
               	movabsq	$-0x6655443322110100, %rcx # imm = 0x99AABBCCDDEEFF00
               	movq	%rcx, 0x18(%rax)
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	leaq	<rip>, %rsi
               	syscall
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rsi
               	addq	%rsi, %rdx
               	movq	%gs:(%rdx), %rdx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	(%rcx), %rdx
               	addq	$0x10, %rdx
               	movq	%gs:(%rdx), %rdx
               	movabsq	$-0x6655443322110100, %r11 # imm = 0x99AABBCCDDEEFF00
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	(%rax), %rdx
               	addq	$0x18, %rdx
               	movq	%gs:(%rdx), %rdx
               	movabsq	$-0x6655443322110100, %r11 # imm = 0x99AABBCCDDEEFF00
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	(%rcx), %rdx
               	addq	$0x10, %rdx
               	movl	%gs:(%rdx), %edx
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	cmpl	%r11d, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	(%rax), %rdx
               	addq	$0x4, %rdx
               	addq	$0x18, %rdx
               	movzwq	%gs:(%rdx), %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	$0xbbcc, %edx           # imm = 0xBBCC
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	(%rcx), %rcx
               	addq	$0x17, %rcx
               	movzbq	%gs:(%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpl	$0x99, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	(%rax), %rax
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	(%rax), %rcx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	%gs:(%rdx), %rdx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	(%rcx), %rcx
               	movq	(%rax), %rax
               	addq	%rax, %rcx
               	movq	%gs:(%rcx), %rdx
               	pushfq
               	popq	%rax
               	movq	%gs:(%rcx), %rsi
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	movq	%rdx, %rdi
               	cmpq	%r11, %rdx
               	jne	<addr>
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	retq
               	movabsq	$-0x5a5a5a5a5a5a5a5b, %rax # imm = 0xA5A5A5A5A5A5A5A5
               	leaq	0x38(%rcx), %rdx
               	movq	%rax, %gs:(%rdx)
               	pushfq
               	popq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	0x38(%rcx), %rax
               	movq	%gs:(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, %gs:(%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movabsq	$0xf1e2d3c4b5a6978, %rdx # imm = 0xF1E2D3C4B5A6978
               	addq	$0x20, %rcx
               	movq	%rdx, %gs:(%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	(%rax), %rsi
               	shlq	%rsi
               	movabsq	$-0x112053135014111, %rdi # imm = 0xFEEDFACECAFEBEEF
               	addq	%rsi, %rdx
               	movq	%rdi, %gs:(%rdx)
               	movq	(%rax), %rdx
               	addq	$0x28, %rdx
               	movq	%gs:(%rdx), %rsi
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	addq	%r11, %rsi
               	movq	%rsi, %gs:(%rdx)
               	movq	(%rcx), %rcx
               	addq	$0x38, %rcx
               	movq	%gs:(%rcx), %rdx
               	addq	$0x3, %rdx
               	movq	%rdx, %gs:(%rcx)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	movl	%gs:(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, %gs:(%rax)
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	xorl	%esi, %esi
               	syscall
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rcx
               	movabsq	$0xf1e2d3c4b5a6978, %r11 # imm = 0xF1E2D3C4B5A6978
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	0x10(%rax), %rcx
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movq	0x30(%rax), %rcx
               	movabsq	$0x1111111111111112, %r11 # imm = 0x1111111111111112
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x20(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x38(%rax), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	0x40(%rax), %rcx
               	movabsq	$-0x5a5a5a5a5a5a5a5a, %r11 # imm = 0xA5A5A5A5A5A5A5A6
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movq	0x48(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x50(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x58(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
