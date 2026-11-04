
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
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x6655443322110100, %rax # imm = 0x99AABBCCDDEEFF00
               	movq	%rax, <rip> # <addr>
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	leaq	<rip>, %rsi # <addr>
               	syscall
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	%gs:(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	addq	$0x10, %rax
               	movq	%gs:(%rax), %rax
               	movabsq	$-0x6655443322110100, %r11 # imm = 0x99AABBCCDDEEFF00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	addq	$0x18, %rax
               	movq	%gs:(%rax), %rax
               	movabsq	$-0x6655443322110100, %r11 # imm = 0x99AABBCCDDEEFF00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	addq	$0x10, %rax
               	movl	%gs:(%rax), %eax
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	addq	$0x4, %rax
               	addq	$0x18, %rax
               	movzwq	%gs:(%rax), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xbbcc, %eax           # imm = 0xBBCC
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	addq	$0x17, %rax
               	movzbq	%gs:(%rax), %rax
               	andq	$0xff, %rax
               	cmpl	$0x99, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	%gs:(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	%gs:(%rax), %rcx
               	pushfq
               	popq	%rdx
               	movq	%gs:(%rax), %rsi
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	jne	<addr>
               	cmpq	%rcx, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0xf, %eax
               	retq
               	movabsq	$-0x5a5a5a5a5a5a5a5b, %rcx # imm = 0xA5A5A5A5A5A5A5A5
               	leaq	0x38(%rax), %rdx
               	movq	%rcx, %gs:(%rdx)
               	pushfq
               	popq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x10, %eax
               	retq
               	addq	$0x38, %rax
               	movq	%gs:(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, %gs:(%rax)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0xf1e2d3c4b5a6978, %rcx # imm = 0xF1E2D3C4B5A6978
               	addq	$0x20, %rax
               	movq	%rcx, %gs:(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	shlq	%rcx
               	movabsq	$-0x112053135014111, %rdx # imm = 0xFEEDFACECAFEBEEF
               	addq	%rcx, %rax
               	movq	%rdx, %gs:(%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x28, %rax
               	movq	%gs:(%rax), %rcx
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	addq	%r11, %rcx
               	movq	%rcx, %gs:(%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x38, %rax
               	movq	%gs:(%rax), %rcx
               	addq	$0x3, %rcx
               	movq	%rcx, %gs:(%rax)
               	movq	<rip>, %rax # <addr>
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
               	movq	<rip>, %rax # <addr>
               	movabsq	$0xf1e2d3c4b5a6978, %r11 # imm = 0xF1E2D3C4B5A6978
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x1111111111111112, %r11 # imm = 0x1111111111111112
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x5a5a5a5a5a5a5a5a, %r11 # imm = 0xA5A5A5A5A5A5A5A6
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
