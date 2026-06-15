
struct_member_brace_wrapped_string.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<streq>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsbq	(%rdi), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	incq	%rdi
               	incq	%rsi
               	jmp	<addr>
               	movsbq	(%rdi), %rax
               	movsbq	(%rsi), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsbq	(%rdi), %rax
               	movsbq	(%rsi), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x150, %rsp            # imm = 0x150
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax
               	movq	%rax, %rdi
               	addq	$0x8, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	%rax, %rdi
               	addq	$0x4, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x108(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rcx), %r11
               	movq	%r11, 0x28(%rax)
               	movq	0x30(%rcx), %r11
               	movq	%r11, 0x30(%rax)
               	movq	0x38(%rcx), %r11
               	movq	%r11, 0x38(%rax)
               	movq	0x40(%rcx), %r11
               	movq	%r11, 0x40(%rax)
               	movq	0x48(%rcx), %r11
               	movq	%r11, 0x48(%rax)
               	movq	0x50(%rcx), %r11
               	movq	%r11, 0x50(%rax)
               	movq	0x58(%rcx), %r11
               	movq	%r11, 0x58(%rax)
               	movq	0x60(%rcx), %r11
               	movq	%r11, 0x60(%rax)
               	movq	0x68(%rcx), %r11
               	movq	%r11, 0x68(%rax)
               	movq	0x70(%rcx), %r11
               	movq	%r11, 0x70(%rax)
               	movq	0x78(%rcx), %r11
               	movq	%r11, 0x78(%rax)
               	movq	0x80(%rcx), %r11
               	movq	%r11, 0x80(%rax)
               	movq	0x88(%rcx), %r11
               	movq	%r11, 0x88(%rax)
               	movq	0x90(%rcx), %r11
               	movq	%r11, 0x90(%rax)
               	movq	0x98(%rcx), %r11
               	movq	%r11, 0x98(%rax)
               	movq	0xa0(%rcx), %r11
               	movq	%r11, 0xa0(%rax)
               	movq	0xa8(%rcx), %r11
               	movq	%r11, 0xa8(%rax)
               	movq	0xb0(%rcx), %r11
               	movq	%r11, 0xb0(%rax)
               	movq	0xb8(%rcx), %r11
               	movq	%r11, 0xb8(%rax)
               	movq	0xc0(%rcx), %r11
               	movq	%r11, 0xc0(%rax)
               	movq	0xc8(%rcx), %r11
               	movq	%r11, 0xc8(%rax)
               	movq	0xd0(%rcx), %r11
               	movq	%r11, 0xd0(%rax)
               	movq	0xd8(%rcx), %r11
               	movq	%r11, 0xd8(%rax)
               	movq	0xe0(%rcx), %r11
               	movq	%r11, 0xe0(%rax)
               	movq	0xe8(%rcx), %r11
               	movq	%r11, 0xe8(%rax)
               	movq	0xf0(%rcx), %r11
               	movq	%r11, 0xf0(%rax)
               	movq	0xf8(%rcx), %r11
               	movq	%r11, 0xf8(%rax)
               	movq	0x100(%rcx), %r11
               	movq	%r11, 0x100(%rax)
               	popq	%r11
               	leaq	-0x108(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x8, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x120(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movzbq	0x10(%rcx), %r11
               	movb	%r11b, 0x10(%rax)
               	movzbq	0x11(%rcx), %r11
               	movb	%r11b, 0x11(%rax)
               	movzbq	0x12(%rcx), %r11
               	movb	%r11b, 0x12(%rax)
               	movzbq	0x13(%rcx), %r11
               	movb	%r11b, 0x13(%rax)
               	popq	%r11
               	leaq	-0x120(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x9, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x120(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x4, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
