
inline_stack_passed_params.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<relay_out_of_line>:
               	popq	%r10
               	subq	$0xb0, %rsp
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	movq	0xc0(%rsp), %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0xc8(%rsp), %rax
               	movq	%rax, 0x90(%rsp)
               	movq	0xd0(%rsp), %rax
               	movq	%rax, 0xa0(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movswq	%r8w, %r8
               	movl	%ecx, %ebx
               	andq	$0xff, %r9
               	movsbq	0x70(%rbp), %rax
               	movq	0x80(%rbp), %r12
               	movslq	0x90(%rbp), %rcx
               	movq	0xa0(%rbp), %r13
               	movq	0xb0(%rbp), %r14
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movswq	%r8w, %r8
               	leaq	<rip>, %r15
               	movslq	(%r15), %r15
               	cmpq	%r15, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	%ebx, %edx
               	leaq	<rip>, %rsi
               	movl	(%rsi), %esi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movswq	(%rdx), %rdx
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movq	%r9, %rdx
               	andq	$0xff, %rdx
               	leaq	<rip>, %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movsbq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	movq	%r12, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	leaq	<rip>, %rdx
               	movzwq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	movl	%r14d, %eax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movabsq	$-0x2, %rsi
               	movabsq	$0x1122334455667788, %rdx # imm = 0x1122334455667788
               	movl	$0xf0000003, %ecx       # imm = 0xF0000003
               	movabsq	$-0x5, %r8
               	movl	$0xfa, %r9d
               	movabsq	$-0x7, %rbx
               	movabsq	$0x11111111ea60, %r12   # imm = 0x11111111EA60
               	movl	$0x9, %r13d
               	movabsq	$-0xa, %r14
               	movabsq	$0x123456789abcdef0, %r15 # imm = 0x123456789ABCDEF0
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	callq	*%rax
               	addq	$0x30, %rsp
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	$0xf0000003, %r11d      # imm = 0xF0000003
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movswq	(%rax), %rax
               	cmpq	$-0x5, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0xfa, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpq	$-0x7, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	cmpq	$0xea60, %rax           # imm = 0xEA60
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$-0xa, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	$0x9abcdef0, %r11d      # imm = 0x9ABCDEF0
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
