
fn_ptr_decay_inside_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400248 <.text+0x28>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	addq	$0x64, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0x1, %r9d
               	movslq	%r9d, %r11
               	cmpq	$0x0, %r11
               	jne	0x4002bb <.text+0x9b>
               	movl	$0x1, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x7b(%rip), %r15       # 0x400237 <.text+0x17>
               	movq	%r15, -0x30(%rbp)
               	jmp	0x400307 <.text+0xe7>
               	leaq	-0x8b(%rip), %rbx       # 0x400237 <.text+0x17>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r14
               	movl	$0x1, %r15d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	movq	%r14, %r15
               	addq	%rax, %r15
               	movl	%r15d, (%r12)
               	leaq	-0x8(%rbp), %r14
               	movslq	(%r14), %r12
               	movl	$0x2, %r15d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	movq	%r12, %r15
               	addq	%rax, %r15
               	movl	%r15d, (%r14)
               	jmp	0x4002ab <.text+0x8b>
               	movq	-0x30(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x400351 <.text+0x131>
               	jmp	0x400329 <.text+0x109>
               	xorq	%r15, %r15
               	movq	%r15, -0x30(%rbp)
               	jmp	0x400307 <.text+0xe7>
               	leaq	-0x8(%rbp), %rbx
               	movslq	(%rbx), %r15
               	movl	$0x3, %r12d
               	movq	-0x30(%rbp), %r14
               	movq	%r14, %r11
               	movq	%r12, %rdi
               	callq	*%r11
               	movq	%r15, %r14
               	addq	%rax, %r14
               	movl	%r14d, (%rbx)
               	jmp	0x40031d <.text+0xfd>
               	leaq	-0x121(%rip), %r14      # 0x400237 <.text+0x17>
               	movq	%r14, -0x48(%rbp)
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r15
               	leaq	-0x48(%rbp), %rbx
               	movq	(%rbx), %r14
               	movl	$0x4, %ebx
               	movq	%r14, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%r15, %rbx
               	addq	%rax, %rbx
               	movl	%ebx, (%r12)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x19a, %rax            # imm = 0x19A
               	jne	0x4003a0 <.text+0x180>
               	xorq	%rax, %rax
               	movq	%rax, -0x60(%rbp)
               	jmp	0x4003ae <.text+0x18e>
               	movl	$0x2, %eax
               	movq	%rax, -0x60(%rbp)
               	jmp	0x4003ae <.text+0x18e>
               	movq	-0x60(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
