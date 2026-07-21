
inline_asm_x64_flag_outputs.x64:	file format elf64-x86-64

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
               	subq	$0x120, %rsp            # imm = 0x120
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, -0x78(%rbp)
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x80(%rbp), %rdi
               	movq	-0x78(%rbp), %r8
               	movq	%rax, -0x120(%rbp)
               	movq	%rcx, -0x118(%rbp)
               	movq	%rbx, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	movq	%rdi, -0x100(%rbp)
               	movq	%r8, -0xf8(%rbp)
               	movq	%rcx, -0xf0(%rbp)
               	movq	-0xf8(%rbp), %rax
               	movq	-0xf0(%rbp), %rcx
               	addq	%rcx, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	-0x108(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x100(%rbp), %r11
               	movb	%bl, (%r11)
               	movq	-0x120(%rbp), %rax
               	movq	-0x118(%rbp), %rcx
               	movq	-0x110(%rbp), %rbx
               	movq	-0x78(%rbp), %rax
               	movq	%rax, (%rdx)
               	movzbq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movq	%rax, (%rsi)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ecx
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rax
               	leaq	-0x90(%rbp), %rdi
               	movq	-0x88(%rbp), %r8
               	movq	%rax, -0x120(%rbp)
               	movq	%rcx, -0x118(%rbp)
               	movq	%rbx, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	movq	%rdi, -0x100(%rbp)
               	movq	%r8, -0xf8(%rbp)
               	movq	%rcx, -0xf0(%rbp)
               	movq	-0xf8(%rbp), %rax
               	movq	-0xf0(%rbp), %rcx
               	addq	%rcx, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	-0x108(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x100(%rbp), %r11
               	movb	%bl, (%r11)
               	movq	-0x120(%rbp), %rax
               	movq	-0x118(%rbp), %rcx
               	movq	-0x110(%rbp), %rbx
               	movq	-0x88(%rbp), %rax
               	movq	%rax, (%rdx)
               	movzbq	-0x90(%rbp), %rax
               	addq	$0xc, %rax
               	movq	%rax, (%rsi)
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0xd, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x98(%rbp), %rcx
               	movq	%rax, -0x120(%rbp)
               	movq	%rbx, -0x118(%rbp)
               	movq	%rcx, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	movq	-0x108(%rbp), %rbx
               	testq	%rbx, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x110(%rbp), %r11
               	movb	%al, (%r11)
               	movq	-0x120(%rbp), %rax
               	movq	-0x118(%rbp), %rbx
               	movzbq	-0x98(%rbp), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	leaq	-0xa0(%rbp), %rcx
               	movq	%rax, -0x120(%rbp)
               	movq	%rbx, -0x118(%rbp)
               	movq	%rcx, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	movq	-0x108(%rbp), %rbx
               	testq	%rbx, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x110(%rbp), %r11
               	movb	%al, (%r11)
               	movq	-0x120(%rbp), %rax
               	movq	-0x118(%rbp), %rbx
               	movzbq	-0xa0(%rbp), %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	leaq	-0xa8(%rbp), %rcx
               	movq	%rax, -0x120(%rbp)
               	movq	%rbx, -0x118(%rbp)
               	movq	%rcx, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	movq	-0x108(%rbp), %rbx
               	testq	%rbx, %rbx
               	sets	%al
               	movzbq	%al, %rax
               	movq	-0x110(%rbp), %r11
               	movb	%al, (%r11)
               	movq	-0x120(%rbp), %rax
               	movq	-0x118(%rbp), %rbx
               	movzbq	-0xa8(%rbp), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	leaq	-0xb0(%rbp), %rcx
               	movq	%rax, -0x120(%rbp)
               	movq	%rbx, -0x118(%rbp)
               	movq	%rcx, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	movq	-0x108(%rbp), %rbx
               	testq	%rbx, %rbx
               	sets	%al
               	movzbq	%al, %rax
               	movq	-0x110(%rbp), %r11
               	movb	%al, (%r11)
               	movq	-0x120(%rbp), %rax
               	movq	-0x118(%rbp), %rbx
               	movzbq	-0xb0(%rbp), %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movl	$0x1, %ecx
               	movq	%rax, -0xc0(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0xb8(%rbp), %rdx
               	movq	-0xc0(%rbp), %rsi
               	movq	%rax, -0x120(%rbp)
               	movq	%rcx, -0x118(%rbp)
               	movq	%rbx, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	movq	%rdx, -0x100(%rbp)
               	movq	%rsi, -0xf8(%rbp)
               	movq	%rcx, -0xf0(%rbp)
               	movq	-0xf8(%rbp), %rax
               	movq	-0xf0(%rbp), %rcx
               	addq	%rcx, %rax
               	seto	%bl
               	movzbq	%bl, %rbx
               	movq	-0x108(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x100(%rbp), %r11
               	movb	%bl, (%r11)
               	movq	-0x120(%rbp), %rax
               	movq	-0x118(%rbp), %rcx
               	movq	-0x110(%rbp), %rbx
               	movzbq	-0xb8(%rbp), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	leaq	-0xc8(%rbp), %rdx
               	movq	-0xd0(%rbp), %rsi
               	movq	%rax, -0x120(%rbp)
               	movq	%rcx, -0x118(%rbp)
               	movq	%rbx, -0x110(%rbp)
               	movq	%rcx, -0x108(%rbp)
               	movq	%rdx, -0x100(%rbp)
               	movq	%rsi, -0xf8(%rbp)
               	movq	%rax, -0xf0(%rbp)
               	movq	-0xf8(%rbp), %rax
               	movq	-0xf0(%rbp), %rcx
               	addq	%rcx, %rax
               	seto	%bl
               	movzbq	%bl, %rbx
               	movq	-0x108(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x100(%rbp), %r11
               	movb	%bl, (%r11)
               	movq	-0x120(%rbp), %rax
               	movq	-0x118(%rbp), %rcx
               	movq	-0x110(%rbp), %rbx
               	movzbq	-0xc8(%rbp), %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movl	$0x7, %ecx
               	movabsq	$-0x1, %rdx
               	movl	%edx, -0xd8(%rbp)
               	leaq	-0xd8(%rbp), %rdx
               	movq	%rax, -0x120(%rbp)
               	movq	%rcx, -0x118(%rbp)
               	movq	%rbx, -0x110(%rbp)
               	movq	%rdx, -0x108(%rbp)
               	movq	%rax, -0x100(%rbp)
               	movq	%rcx, -0xf8(%rbp)
               	movq	-0x100(%rbp), %rbx
               	movq	-0xf8(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x108(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x120(%rbp), %rax
               	movq	-0x118(%rbp), %rcx
               	movq	-0x110(%rbp), %rbx
               	movslq	-0xd8(%rbp), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movabsq	$-0x1, %rcx
               	movl	%ecx, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rcx
               	movq	%rax, -0x120(%rbp)
               	movq	%rcx, -0x118(%rbp)
               	movq	%rbx, -0x110(%rbp)
               	movq	%rcx, -0x108(%rbp)
               	movq	%rax, -0x100(%rbp)
               	movq	%rax, -0xf8(%rbp)
               	movq	-0x100(%rbp), %rbx
               	movq	-0xf8(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x108(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x120(%rbp), %rax
               	movq	-0x118(%rbp), %rcx
               	movq	-0x110(%rbp), %rbx
               	movslq	-0xe0(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
