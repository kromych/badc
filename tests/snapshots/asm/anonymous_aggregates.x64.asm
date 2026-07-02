
anonymous_aggregates.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movabsq	$0x1234567890abcdef, %rcx # imm = 0x1234567890ABCDEF
               	movq	%rcx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	movl	$0x90abcdef, %r11d      # imm = 0x90ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	movl	$0x90abcdef, %r11d      # imm = 0x90ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0xcafebabe, %ecx       # imm = 0xCAFEBABE
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xbadf00d, %ecx        # imm = 0xBADF00D
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	movl	$0xcafebabe, %r11d      # imm = 0xCAFEBABE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xbadf00d, %rax        # imm = 0xBADF00D
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movabsq	$0xbadf00dcafebabe, %r11 # imm = 0xBADF00DCAFEBABE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x2a, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x63, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movabsq	$0x40091eb851eb851f, %rcx # imm = 0x40091EB851EB851F
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x8(%rax,%riz)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x14, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	$0xa, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x14, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x1e, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x28, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0x4(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x5678, %ecx           # imm = 0x5678
               	movw	%cx, 0x6(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x9, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movswq	0x4(%rax), %rax
               	cmpq	$0x1234, %rax           # imm = 0x1234
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movswq	0x6(%rax), %rax
               	cmpq	$0x5678, %rax           # imm = 0x5678
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x56781234, %eax       # imm = 0x56781234
               	leaq	-0x40(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	movl	%ecx, %ecx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x22, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movl	$0x58, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x58(%rbp), %rax
               	movl	$0x61, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x58(%rbp), %rax
               	movl	$0x62, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x58(%rbp), %rax
               	movl	$0x63, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x58(%rbp), %rax
               	movl	$0x64, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x58(%rbp), %rax
               	movabsq	$0x123456789abcdef0, %rcx # imm = 0x123456789ABCDEF0
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x58(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x58, %rax
               	je	<addr>
               	movl	$0x28, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movsbq	0x1(%rax), %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movsbq	0x2(%rax), %rax
               	cmpq	$0x62, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movsbq	0x3(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movsbq	0x4(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x2c, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movabsq	$0x123456789abcdef0, %r11 # imm = 0x123456789ABCDEF0
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2d, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
