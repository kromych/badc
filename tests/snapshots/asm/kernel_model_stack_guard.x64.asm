
kernel_model_stack_guard.x64:	file format elf64-x86-64

Disassembly of section .text:

<set_intr_gate>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%gs:0x28, %r11
               	movq	%r11, -0x8(%rbp)
               	xorl	%r11d, %r11d
               	movq	%rsi, %rax
               	leaq	-0x20(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	%edi, (%rsi)
               	movl	$0x10, 0x4(%rsi)
               	movq	%rax, 0x8(%rsi)
               	movq	$0x0, %rdi
		R_X86_64_32S	idt_table
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
		R_X86_64_PLT32	idt_setup_from_table-0x4
               	movq	%gs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
		R_X86_64_PLT32	__stack_chk_fail-0x4
               	xorl	%r11d, %r11d
               	leave
               	retq
